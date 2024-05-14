class SignerResModel {
  String? processType;
  String? id;
  String? self;
  Tasks? tasks;
  List<Documents>? documents;

  SignerResModel(
      {this.processType, this.id, this.self, this.tasks, this.documents});

  SignerResModel.fromJson(Map<String, dynamic> json) {
    processType = json['process_type'];
    id = json['id'];
    self = json['self'];
    tasks = json['tasks'] != null ? new Tasks.fromJson(json['tasks']) : null;
    if (json['documents'] != null) {
      documents = [];
      json['documents'].forEach((v) {
        documents!.add(new Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['process_type'] = this.processType;
    data['id'] = this.id;
    data['self'] = this.self;
    if (this.tasks != null) {
      data['tasks'] = this.tasks!.toJson();
    }
    if (this.documents != null) {
      data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tasks {
  List<Pending>? pending = [];

  Tasks({this.pending});

  Tasks.fromJson(Map<String, dynamic> json) {
    if (json['pending'] != null) {
      json['pending'].forEach((v) {
        pending!.add(new Pending.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pending != null) {
      data['pending'] = this.pending!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pending {
  String? type;
  String? id;
  String? url;

  Pending({this.type, this.id, this.url});

  Pending.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['url'] = this.url;
    return data;
  }
}

class Documents {
  String? id;
  String? url;
  String? content;

  Documents({this.id, this.url, this.content});

  Documents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['content'] = this.content;
    return data;
  }
}
