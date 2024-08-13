import 'package:localstore/localstore.dart';
import 'package:logger/logger.dart';
import 'package:travel_claim/models/claim_form.dart';

class LocalStorageDataProvider {
  static const String claims = 'claims';


  Future<bool> clear() async {
    try {
      final db = Localstore.instance;
      await db.collection(claims).delete();
      return true;
    }catch(_){
      print('local storage clear error: ${_.toString()}');
      return false;
    }
  }

  Future<List<ClaimForm>> getClaims() async {
    try {
      final db = Localstore.instance;
      final items = await db.collection(claims).get();
     // Logger().i(items);
      List<ClaimForm> forms = [];
      items?.entries.forEach((element) {
        final item = ClaimForm.fromJson(element.value);
        forms.add(item);

      });
      return forms;
    }catch(_){
      print('local storage get error: ${_.toString()}');
      return [];
    }
  }

  Future<bool> saveOrUpdate(ClaimForm data) async {
    if(data.storageId.isEmpty){
      // create new draft
      return await save(data);
    }else{
      return await update(data);
    }
  }

  Future<bool> save(ClaimForm data) async {
    try{
     // Logger().i(data.toJson());
      final db = Localstore.instance;
      final id = db.collection(claims).doc().id;
      data.storageId = id;
      await db.collection(claims).doc(id).set(data.toJson());
      return true;
    }catch(_){
      print('local storage save error: ${_.toString()}');
      return false;
    }
  }

  Future<bool> update(ClaimForm data) async {
    try{
    //  Logger().i(data.toJson());
      final db = Localstore.instance;
      await db.collection(claims).doc(data.storageId).set(data.toJson());
      return true;
    }catch(_){
      print('local storage update error: ${_.toString()}');
      return false;
    }
  }

  Future<bool> delete(String id) async {
    try{
      final db = Localstore.instance;
      await db.collection(claims).doc(id).delete();
      return true;
    }catch(_){
      print('local storage delete error: ${_.toString()}');
      return false;
    }
  }
}
