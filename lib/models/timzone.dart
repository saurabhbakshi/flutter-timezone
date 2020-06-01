class TimeZone {
  int _id;
  // String _region;
  // String _city;
  String _timeZone;
  // String _abbrevation;

  // TimeZone(this._region, this._city, this._timeZone, [this._abbrevation]);
  // TimeZone.withId(this._id, this._region, this._city, this._timeZone,
  //     [this._abbrevation]);
  TimeZone(this._timeZone);
  TimeZone.withId(this._id, this._timeZone);
  int get id => _id;
  // String get region => _region;
  // String get city => _city;
  String get timezone => _timeZone;
  // String get abbrevation => _abbrevation;

  // set region(String deducedRegion) {
  //   if (deducedRegion != null) {
  //     _region = deducedRegion;
  //   }
  // }

  // set city(String deducedCity) {
  //   if (deducedCity != null) {
  //     _city = deducedCity;
  //   }
  // }

  set timezone(String deducedTimeZone) {
    if (deducedTimeZone != null) {
      _timeZone = deducedTimeZone;
    }
  }

  // set abbrevation(String deducedAbbrevation) {
  //   if (deducedAbbrevation != null) {
  //     _abbrevation = deducedAbbrevation;
  //   }
  // }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    // map['region'] = _region;
    // map['city'] = _city;
    map['timezone'] = _timeZone;
    // map['abbrevation'] = _abbrevation;
    if (_id != null) {
      map['id'] = _id;
    }
    return map;
  }

  TimeZone.fromObject(dynamic o) {
    this._id = o['id'];
    // this._region = o['region'];
    // this._city = o['city'];
    // this._abbrevation = o['abbrevation'];
    this._timeZone = o['timezone'];
  }
}
