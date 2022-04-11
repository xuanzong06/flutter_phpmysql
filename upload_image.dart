
static final String uploadEndPoint = 'http://localhost/flutter_test/upload_image.php';
Future<File> file;

String status = '';
String base64Image;
File tmpFile;
String errMessage = 'Error Uploading Image';

chooseImage(){
  setState((){
    file = ImagePicker.pickImage(source: ImageSource.gallery);
  }); 
  setStatus(''); 
}

setStatus(String message){
  setState((){
    status  = message;
  });
}

startUpload(){
  setStatus('Uploading Image...');
  if(null == tmpFile){
    setStatus(errMessage);
    return ;
  }
  String fileName = tmpFile.path.split('/').last;
  upload(fileName);
}

upload(String fileName){
  http.post(uploadEndPoint, body: {
    "image" : base64Image,
    "name" : fileName,    
  }).then((result){
    setState(result.statusCode == 200 ? result.body: errMessage);
  }).catchError((error){
    setStatus(error);

  });
}

widget showImage(){
  return FutureBuilder<File>(
    future: file,
    builder : (BuildContext context, AsyncSnapshot<File> snapshot)
    {
      if(snapshot.connectionState == connectionState.done && null != snapshot.data){

        tmpFile = snapshot.data;

        base64Image = base64Encode(snapshot.data.readAsBytesSync());



        return Flexible(
          child : Image.file(snapshot.data, fit:BoxFit.fill,),
        );
      }else if(null != snapshot.error){
        return const Text(
          'Error Picking Image',
          textAlign : TextAlign.center,
        );
      }else{
        return const Text(
          'No Image Selected',
          textAlign : TextAlign.center,
        );
      }
    }
  );

}


return Scaffold(
  body:Container(
    padding: EdgeInsets.all(30.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children : <Widget>[
        OutlinedButton(
          onPerssed:chooseImage,
          child: Text('Choose Image'),
        ),
        SizedBox(height: 20.0,),
        showImage(),
        SizedBox(height: 20.0,),
        OutlinedButton(
          onPerssed:startUpload,
          child: Text('Upload Image'),
        ),
        SizedBox(height: 20.0,),
        Text(
          status,
          textAlign : textAlign.center,
          style: TextStyle(
            color: Colors.green,
            fontWeight:FontWeight.w500,
            fontSize: 20.0,
          ),
        ),
        SizedBox(height: 20.0,),
      ],
    ),
  ),
);