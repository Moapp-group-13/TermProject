class GETROOMLIST {
  List<Roomlist>? roomlist;

  GETROOMLIST({this.roomlist});

  GETROOMLIST.fromJson(Map<String, dynamic> json) {
    if (json['roomlist'] != null) {
      roomlist = <Roomlist>[];
      json['roomlist'].forEach((v) {
        roomlist!.add(new Roomlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.roomlist != null) {
      data['roomlist'] = this.roomlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roomlist {
  int? id;
  int? group;
  int? manager;
  String? title;
  int? size;
  int? period;
  LastHistory? lastHistory;

  Roomlist(
      {this.id,
        this.group,
        this.manager,
        this.title,
        this.size,
        this.period,
        this.lastHistory});

  Roomlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    group = json['group'];
    manager = json['manager'];
    title = json['title'];
    size = json['size'];
    period = json['period'];
    lastHistory = json['last_history'] != null
        ? new LastHistory.fromJson(json['last_history'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group'] = this.group;
    data['manager'] = this.manager;
    data['title'] = this.title;
    data['size'] = this.size;
    data['period'] = this.period;
    if (this.lastHistory != null) {
      data['last_history'] = this.lastHistory!.toJson();
    }
    return data;
  }
}

class LastHistory {
  int? id;
  int? room;
  Author? author;
  String? createDate;
  String? modifyDate;
  int? event;
  String? image;
  String? text;

  LastHistory(
      {this.id,
        this.room,
        this.author,
        this.createDate,
        this.modifyDate,
        this.event,
        this.image,
        this.text});

  LastHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    room = json['room'];
    author =
    json['author'] != null ? new Author.fromJson(json['author']) : null;
    createDate = json['create_date'];
    modifyDate = json['modify_date'];
    event = json['event'];
    image = json['image'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['room'] = this.room;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    data['create_date'] = this.createDate;
    data['modify_date'] = this.modifyDate;
    data['event'] = this.event;
    data['image'] = this.image;
    data['text'] = this.text;
    return data;
  }
}

class Author {
  String? nickname;
  int? icon;
  String? stateMessage;
  User? user;

  Author({this.nickname, this.icon, this.stateMessage, this.user});

  Author.fromJson(Map<String, dynamic> json) {
    nickname = json['nickname'];
    icon = json['icon'];
    stateMessage = json['state_message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickname'] = this.nickname;
    data['icon'] = this.icon;
    data['state_message'] = this.stateMessage;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class UserToken {
  int? pk;
  String? token;

  UserToken({this.pk, this.token});

  UserToken.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk'] = this.pk;
    data['token'] = this.token;
    return data;
  }
}

class Profile {
  String? nickname;
  int? icon;
  String? stateMessage;
  User? user;

  Profile({this.nickname, this.icon, this.stateMessage, this.user});

  Profile.fromJson(Map<String, dynamic> json) {
    nickname = json['nickname'];
    icon = json['icon'];
    stateMessage = json['state_message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickname'] = this.nickname;
    data['icon'] = this.icon;
    data['state_message'] = this.stateMessage;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? username;

  User({this.id, this.username});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    return data;
  }
}
class Statics {
  List<Liststatics>? liststatics;

  Statics({this.liststatics});

  Statics.fromJson(Map<String, dynamic> json) {
    if (json['liststatics'] != null) {
      liststatics = <Liststatics>[];
      json['liststatics'].forEach((v) {
        liststatics!.add(new Liststatics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.liststatics != null) {
      data['liststatics'] = this.liststatics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Liststatics {
  int? user;
  int? room;
  String? date;
  int? score;

  Liststatics({this.user, this.room, this.date, this.score});

  Liststatics.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    room = json['room'];
    date = json['date'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['room'] = this.room;
    data['date'] = this.date;
    data['score'] = this.score;
    return data;
  }
}
