import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';
import 'photos_loader.dart';

class ImageListState extends State<ImageList> {

  List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random Photos"),
      ),
      body: Padding(
        child: FutureBuilder<List<Photo>>(
          future: fetchPhotos(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            photos = snapshot.data;
            return snapshot.hasData
                ? _listOfCards()
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
        padding: EdgeInsets.all(16.0),
      ),
    );
  }

  Widget _listOfCards() {
    return ListView.builder(
        itemCount: photos.length,
        itemBuilder: (context, i) {
          return Container(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => _pushPhoto(photos[i]),
                    child: Image.network(
                      photos[i].small,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    title: Text(photos[i].title),
                    subtitle: Text(photos[i].author),
                  )
                ],
              ),
            ),
          );
        });
  }

  void _pushPhoto(Photo photo) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Container(
            child: PhotoView(
              imageProvider: NetworkImage(photo.large)
            ),
          );
        }
      )
    );
  }
}

class ImageList extends StatefulWidget {
  @override
  ImageListState createState() => ImageListState();
}
