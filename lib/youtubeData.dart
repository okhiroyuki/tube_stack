class YoutubeData{
  String _url;
  String _title;
  String _thumbnailUrl;

  YoutubeData(utl, title, thumbnailUrl){
    _url = utl;
    _title = title;
    _thumbnailUrl = thumbnailUrl;
  }

  String getUrl(){
    return _url;
  }

  String getTitle(){
    return _title;
  }

  String getThumbnailUtl(){
    return _thumbnailUrl;
  }
}