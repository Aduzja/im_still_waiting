import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_still_waiting/models/item_model.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(const HomePageState());

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    _streamSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .orderBy('release_date')
        .snapshots()
        .listen(
      (itemsRaw) {
        final items = itemsRaw.docs
            .map(
              (item) => ItemModel(
                id: item.id,
                imageURL: item['image_url'],
                title: item['title'],
                releaseDate: (item['release_date'] as Timestamp).toDate(),
              ),
            )
            .toList();
        emit(HomePageState(items: items));
      },
    )..onError(
        (error) {
          emit(const HomePageState(loadingErrorOccured: true));
        },
      );
  }

  Future<void> remove(ItemModel model) async {
    try {
      final userID = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('items')
          .doc(model.id)
          .delete();
    } catch (error) {
      emit(
        const HomePageState(
          removingErrorOccured: true,
        ),
      );
      start();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
