import 'package:clean_space/app/locator.dart';
import 'package:clean_space/models/user_profile.dart';
import 'package:clean_space/models/post.dart';
import 'package:clean_space/models/area.dart';
import 'package:clean_space/services/firestore_service.dart';
import 'package:clean_space/utils/constants/firebase/firestore_collections.dart';

abstract class PostsServiceBase{
  Stream<Post> getAllPosts();
  Stream<Post> getAllPostsOf(UserProfile user);
  Stream<Post> getPostsByArea(Area area);
  Future<int> getPostsByAreaCount(Area area);
  Future<Post> getPost(id);

  Future<void> createPost(Post post);
  Future<void> deletePost(id);
  Future<void> updatePost(Post post);
}

class PostsService implements PostsServiceBase{
  FirestoreService _firestoreService = locator<FirestoreService>();
  String postsCollectionPath = FireStoreCollections.posts;

  @override
  Future<void> createPost(Post post) {
    return _firestoreService.addData(postsCollectionPath, post.toJson());
  }

  @override
  Future<void> deletePost(id) {
    String path = "$postsCollectionPath/$id";
    return _firestoreService.deleteDocument(path);
  }

  @override
  Stream<Post> getAllPosts() {
    return _firestoreService.getAllDocuments(postsCollectionPath, (snapshot) => Post.fromSnapshot(snapshot));
  }

  @override
  Stream<Post> getAllPostsOf(UserProfile user) {
    // TODO: implement getAllPostsOf
    throw UnimplementedError();
  }

  @override
  Future<Post> getPost(id) {
    String path = "$postsCollectionPath/$id";
    return _firestoreService.getDocument<Post>(path, (snapshot) => Post.fromSnapshot(snapshot));
  }

  @override
  Stream<Post> getPostsByArea(Area area) {
    // TODO: implement getPostsByArea
    throw UnimplementedError();
  }

  @override
  Future<int> getPostsByAreaCount(Area area) {
    // TODO: implement getPostsByAreaCount
    throw UnimplementedError();
  }

  @override
  Future<void> updatePost(Post post) {
    String path = "$postsCollectionPath/${post.id}";
    return _firestoreService.updateData(path, post.toJson());
  }

}