import 'dart:io';

import 'package:clean_space/app/locator.dart';
import 'package:clean_space/errors/failure.dart';
import 'package:clean_space/models/user_profile.dart';
import 'package:clean_space/models/post.dart';
import 'package:clean_space/models/area.dart';
import 'package:clean_space/services/firestore_service.dart';
import 'package:clean_space/utils/constants/firebase/firebase_storage_buckets.dart';
import 'package:clean_space/utils/constants/firebase/firestore_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class PostsServiceBase{
  Stream<List<Post>> getAllPosts();
  Stream<List<Post>> getAllPostsOf(UserProfile user);
  Stream<List<Post>> getPostsByArea(Location location);
  Future<int> getPostsByAreaCount(Location location);
  Future<Post> getPost(id);

  Future<void> createPost(Post post);
  Future<void> deletePost(id);
  Future<void> updatePost(Post post);
}

class PostsService implements PostsServiceBase{
  FirebaseFirestore _firestore = locator<FirebaseFirestore>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  static FirebaseStorage _firebaseStorage = locator<FirebaseStorage>();
  String postsCollectionPath = FireStoreCollections.posts;


  final _postImagesBucket =
  _firebaseStorage.ref(FirebaseStorageBuckets.postsImages);


  @override
  Future<void> createPost(Post post) {
    return _firestoreService.addData(postsCollectionPath, post.toMap());
  }

  @override
  Future<void> deletePost(id) {
    String path = "$postsCollectionPath/$id";
    return _firestoreService.deleteDocument(path);
  }

  @override
  Stream<List<Post>> getAllPosts({bool isComplaint = false}) {
    return _firestoreService.collectionStream<Post>(postsCollectionPath, (snapshot) => Post.fromSnapshot(snapshot)).map((posts) => posts.where((post) => post.isComplaint == isComplaint).toList());
  }

  @override
  Stream<List<Post>> getAllPostsOf(UserProfile user, {bool isComplaint = false}) {
    return _firestoreService.getDataStreamFromQuerySnapShotStream<Post>(
        _firestore.collection(postsCollectionPath).where("author", isEqualTo: user.uid).orderBy("createdAt", descending: true).snapshots(),
            (snapshot) => Post.fromSnapshot(snapshot)
    ).map((posts) => posts.where((post) => post.isComplaint == isComplaint).toList());
  }

  @override
  Future<Post> getPost(id) {
    String path = "$postsCollectionPath/$id";
    return _firestoreService.getDocument<Post>(path, (snapshot) => Post.fromSnapshot(snapshot));
  }

  @override
  Stream<List<Post>> getPostsByArea(Location location, {isComplaint = false}) {
    return _firestoreService.getDataStreamFromQuerySnapShotStream<Post>(
        _firestore.collection(postsCollectionPath).where("location", isEqualTo: location.toStringForDatabase()).orderBy("createdAt", descending: true).snapshots(),
            (snapshot) => Post.fromSnapshot(snapshot)
    ).map((posts) => posts.where((post) => post.isComplaint == isComplaint).toList());
  }

  @override
  Future<int> getPostsByAreaCount(Location location, {bool isComplaint = false}) async {
    List<Post> posts =  await getPostsByArea(location, isComplaint: isComplaint).first;
    return posts.length;
  }

  @override
  Future<void> updatePost(Post post) {
    String path = "$postsCollectionPath/${post.id}";
    return _firestoreService.updateData(path, post.toMap());
  }

  Future<String> uploadImageAndGetDownloadableUrl(
      File image, String imageName) async {
    final imageReference = _postImagesBucket.child(imageName);
    try {
      await imageReference.putFile(image);
      return imageReference.getDownloadURL();
    } on FirebaseException catch (e) {
      print("A firebase exception has occured: $e");
      throw Failure(message: e.message);
    }
  }

  Future<List<String>> getAllLocationsFromPost()async{
    final qs = await _firestore.collection(postsCollectionPath).get();
    return qs.docs.map<String>((p) => p['location'] as String).toSet().toList();
  }

  Future<void> addLike(Post post, UserProfile userProfile) {
    return _firestore.collection(postsCollectionPath).doc(post.id).collection("likes").doc(userProfile.uid).set(userProfile.toMapForLikes());
  }

  Future<void> removeLike (Post post, UserProfile userProfile){
    return _firestore.collection(postsCollectionPath).doc(post.id).collection("likes").doc(userProfile.uid).delete();
  }

  Stream<List<PostLike>> getLikesOf(Post post){
   return _firestoreService.getDataStreamFromQuerySnapShotStream<PostLike>(
       _firestore.collection(postsCollectionPath).doc(post.id).collection("likes").snapshots(),
            (snapshot) => PostLike.fromMap(snapshot.data(), snapshot.id)
    );
  }

  // Future<void> addComment(Post post, UserProfile userProfile) {
  //
  // }
  //
  // Future<void> removeComment(Post post, UserProfile userProfile){
  // }
  //
  //
  // Stream<List<PostLike>> getCommentsOf(Post post){
  //
  // }

  Future<void> addPostCategory(PostCategory postCategory){
    return _firestore.collection(FireStoreCollections.postCategories).add(postCategory.toMap());
  }
  //
  // Future<void> removePostCategory(PostCategory postCategory){
  //   return _firestore.collection(FireStoreCollections.postCategories).doc(postCategory.id).delete();
  // }

  Stream<List<PostCategory>> getPostCategory({bool isForComplaint = false})
  {
    assert (isForComplaint != null);
    return _firestoreService.getDataStreamFromQuerySnapShotStream<PostCategory>(
        _firestore.collection(FireStoreCollections.postCategories).snapshots(),
            (snapshot) => PostCategory.fromMap(snapshot.data(), snapshot.id)
    ).map((categories) => categories.where((category) => category.isForComplaint == isForComplaint).toList());
  }
}