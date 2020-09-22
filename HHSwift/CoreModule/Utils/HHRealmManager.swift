//
//  HHRealmManager.swift
//  HHSwift
//
//  Created by Jn.Huang on 2020/1/5.
//  Copyright © 2020 huang. All rights reserved.
//
 
import Foundation
import RealmSwift

/**
 Realm  中文文档 https://realm.io/cn/docs/swift/latest/
 Realm  入门教程  https://www.jianshu.com/p/48baaee4e35b
 */

class HHRealmManager: NSObject {
    
    ///
    static let shared = HHRealmManager()
    
    /// 如果要存储的数据模型属性发生变化,需要配置当前版本号比之前大
    static let kRealmDBVersion: UInt64 = 1
    
    /// 数据库路径   /RealmDB/defaultDB.realm
    static var databasePath: URL {
        let fileManager = FileManager.default
        var directoryURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        directoryURL = directoryURL.appendingPathComponent("RealmDB")
        
        if !fileManager.fileExists(atPath: directoryURL.path) {
            try! fileManager.createDirectory(atPath: directoryURL.path, withIntermediateDirectories: true, attributes: nil)
        }
        
        let path = directoryURL.appendingPathComponent("defaultDB").appendingPathExtension("realm")
        return path
    }
    
    
    /// 数据库配置 存到硬盘 
    static var realmDiskConfiguration: Realm.Configuration {
        /**
         - parameter fileURL                        数据库文件位置
         - parameter inMemoryIdentifier             如果设置的话，数据将存放在内存中并以此为标记，fileURL置位nil,反之亦然
         - parameter syncConfiguration
         - parameter encryptionKey                  如果设置的话会用其作为key对数据做AES加密
         - parameter readOnly                       是否只读
         - parameter schemaVersion                  数据库内容的版本号
         - parameter migrationBlock                 如果做版本兼容的话，在block里做转换逻辑
         - parameter deleteRealmIfMigrationNeeded   当数据库内容版本不兼容时是否重新创建
         - parameter shouldCompactOnLaunch
         - parameter objectTypes
         */
        let config = Realm.Configuration(fileURL: HHRealmManager.databasePath,
                                         inMemoryIdentifier: nil,
                                         syncConfiguration: nil,
                                         encryptionKey: nil,
                                         readOnly: false,
                                         schemaVersion: HHRealmManager.kRealmDBVersion,
                                         migrationBlock: { (migration, oldSchemaVersion) in
                                            
                                            if (oldSchemaVersion < HHRealmManager.kRealmDBVersion) {
                                                                                        
                                            }
                                            
        },
                                         deleteRealmIfMigrationNeeded: false,
                                         shouldCompactOnLaunch: nil,
                                         objectTypes: nil)
        return config
    }
    
    /**
     为了在不同的线程中使用同一个 Realm 文件，您需要为您应用的每一个线程初始化一个新的Realm 实例。
     只要您指定的配置是相同的，那么所有的 Realm 实例都将会指向硬盘上的同一个文件。
     */
    var realm: Realm {
        let realm = try! Realm(configuration: HHRealmManager.realmDiskConfiguration)
        return realm
    }
    
}


// MARK: - 扩展增删改查
extension HHRealmManager {
    
    func addModel <T> (model: T) {
        do {
            try realm.write {
                realm.add(model as! Object)
            }
        } catch {}
    }
    
    func queryModel <T> (model: T.Type, filter: String? = nil) -> [T]{
         
         var results : Results<Object>
         
         if filter != nil {
             
             results =  realm.objects((model as! Object.Type).self).filter(filter!)
         }
         else {
             
             results = realm.objects((model as! Object.Type).self)
         }
         
         guard results.count > 0 else { return [] }
         var modelArray = [T]()
         for model in results{
             modelArray.append(model as! T)
         }
         
         return modelArray
     }
     
     func deleteModel <T> (model: T){
         do {
             try realm.write {
                 realm.delete(model as! Object)
             }
         } catch {}
     }
     
     ///删除某张表
     func deleteModelList <T> (model: T){
         
         do {
             try realm.write {
                 realm.delete(realm.objects((T.self as! Object.Type).self))
             }
         }catch {}
     }
     
     ///调用此方法的模型必须具有主键
    func updateModel <T> (model: T){
         do {
             try realm.write {
                
                realm.add(model as! Object, update: Realm.UpdatePolicy.all)
             }
         }catch{}
     }
    
}





// MARK: - 扩展Results
extension Results {

    /**
     转为普通数组
     
     - returns:
     */
    func toArray<T:Object>() -> [T] {
        var arr = [T]()
        for obj in self {
            arr.append(obj as! T)
        }
        return arr
    }
    
}
