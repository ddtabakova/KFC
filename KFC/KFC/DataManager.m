//
//  DataManager.m
//  KFC
//
//  Created by Dobby on 2/14/13.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import "DataManager.h"
#import <CoreData/CoreData.h>
#import "Image.h"
#import "Restaurant.h"
#import "Menu.h"
#import "Type.h"
#import "City.h"

@implementation DataManager

static dispatch_queue_t q;
static NSManagedObjectContext *cdCtx;
static NSManagedObjectModel *managedObjectModel;
static NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (void)initialize {
    q = dispatch_queue_create("BNDataManager Worker Queue", NULL);
    cdCtx = [self managedObjectContext];
};


#pragma mark - CoreData stack

+ (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *localManagedObjectContext = cdCtx;
    if (localManagedObjectContext != nil) {
        if ([localManagedObjectContext hasChanges] && ![localManagedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
}

+ (NSManagedObjectContext *)managedObjectContext {
    if (cdCtx != nil) {
        return cdCtx;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self sharedPersistentStoreCoordinator];
    if (coordinator != nil) {
        cdCtx = [[NSManagedObjectContext alloc] init];
        [cdCtx setPersistentStoreCoordinator:coordinator];
    }
    return cdCtx;
}

+ (NSManagedObjectModel*)managedObjectModel {
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"KFCDataModel" withExtension:@"momd"];
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return managedObjectModel;
}

+ (NSPersistentStoreCoordinator*)sharedPersistentStoreCoordinator {
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    
    @synchronized(self){
        NSURL *storeURL = [[self applicationDocumentsDirectoryURL] URLByAppendingPathComponent:@"KFCDataModel.sqlite"];
        NSString *store = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"KFCDataModel.sqlite"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:store]) {
            NSError *error;
            NSString *sqlitePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"KFCDataModel.sqlite"];
            [[NSFileManager defaultManager] copyItemAtPath:sqlitePath toPath:store error:&error];
            if (error) {
                NSLog(@"Error: %@", [error userInfo]);
            }
        }
        
        NSError *error = nil;
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        
        if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
    
    return persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

+ (NSString*)applicationDocumentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSURL *)applicationDocumentsDirectoryURL {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Default data

+ (void)saveDefaultData {
    //menu data
    //chicken
    Type *t1 = [NSEntityDescription insertNewObjectForEntityForName:@"Type" inManagedObjectContext:cdCtx];
    t1.name = @"Пиле";
    
    Menu *m1 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m1.name = @"Пиле Оригинална рецепта";
    m1.desc = @"100% сочно пилешко месо, готвено под налягане. Тайната на вкуса е в оригиналната рецепта от 11 билки и подправки. (гърди - мин. 130 гр., кълка/цяло крило - мин. 70 гр., бут - мин. 115 гр, филе - мин.115 гр.)";
    m1.price = [NSNumber numberWithDouble:1.1];
    m1.image = @"m1.png";
    [m1 addMenuToTypeObject:t1];
    
    Menu *m2 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m2.name = @"Пикантни крилца";
    m2.desc = @"Хрупкави и сочни, мариновани по специална пикантна рецепта. (3 крилца 75гр., 5 крилца 125 гр, 8 крилца 200)";
    m2.price = [NSNumber numberWithDouble:1.1];
    m2.image = @"m2.png";
    [m2 addMenuToTypeObject:t1];
    
    Menu *m3 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m3.name = @"Бонфиле";
    m3.desc = @"100% сочно бяло, пилешко месо. Приготвено по оригиналата рецепта на KFC, със сос по избор – майонеза, кетчуп или барбекю (BBQ). (3 бонфилета – 85g, 5 бонфилета – 135g, 8 бонфилета – 210g)";
    m3.price = [NSNumber numberWithDouble:1.1];
    m3.image = @"m3.png";
    [m3 addMenuToTypeObject:t1];
    
    Menu *m4 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m4.name = @"Пикантно пиле";
    m4.desc = @"Хрупкаво и сочно пиле в пикантна панировка. (кълка мин 70 гр., бут. мин 115 гр.)";
    m4.price = [NSNumber numberWithDouble:1.1];
    m4.image = @"m4.png";
    [m4 addMenuToTypeObject:t1];
    
    Menu *m5 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m5.name = @"Пикантно бонфиле";
    m5.desc = @"100% сочно бяло, пилешко месо. Мариновано по специална рецепта в пикантна марината, със сос по избор – майонеза, кетчуп или барбекю (BBQ). (3 бонфилета – 85g, 5 бонфилета – 135g, 8 бонфилета – 210g)";
    m5.price = [NSNumber numberWithDouble:1.1];
    m5.image = @"m5.png";
    [m5 addMenuToTypeObject:t1];
    
    [t1 addTypeToMenu:[NSSet setWithObjects:m1, m2, m3, m4, m5, nil]];
    
    //burgers
    Type *t2 = [NSEntityDescription insertNewObjectForEntityForName:@"Type" inManagedObjectContext:cdCtx];
    t2.name = @"Бургери";
    
    Menu *m6 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m6.name = @"Bonburger";
    m6.desc = @"Сочно бонфиле, майонеза, хрупкава салата и хлебче. Бонбургер предлага така неповторимия KFC вкус на специална цена.";
    m6.price = [NSNumber numberWithDouble:1.1];
    m6.image = @"m6.png";
    [m6 addMenuToTypeObject:t2];
    
    Menu *m7 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m7.name = @"Fillet Burger";
    m7.desc = @"Направен от 100% сочно пилешко филе, винаги прясно приготвен по оригиналната рецепта от 11 билки и подправки, хрупкава салата, лек майонезен сос и хлебче по оригинална рецепта.";
    m7.price = [NSNumber numberWithDouble:1.1];
    m7.image = @"m7.png";
    [m7 addMenuToTypeObject:t2];
    
    Menu *m8 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m8.name = @"Боксмастър";
    m8.desc = @"Сочно пилешко филе, картофено кюфте, сирене чедър, свежи домати, салата, лек майонезен сос: всичко във вкусна тортила...повече от 300 гр удоволствие!";
    m8.price = [NSNumber numberWithDouble:1.1];
    m8.image = @"m8.png";
    [m8 addMenuToTypeObject:t2];
    
    Menu *m9 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m9.name = @"Zinger";
    m9.desc = @"100% сочно пилешко филе, мариновано в специалната ни пикантна панировка, прави вкуса на Зингера неустоим, хрупкава салата, лек майонезен сос и хлебче.";
    m9.price = [NSNumber numberWithDouble:1.1];
    m9.image = @"m9.png";
    [m9 addMenuToTypeObject:t2];
    
    Menu *m10 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m10.name = @"Toasted Twister";
    m10.desc = @"Свежа салата, пресни домати, сочно пилешко бонфиле, лек майонезен сос, и всичко това завито във вкусна тортила и запечено на грил. Изключително удобен начин да се насладиш на KFC вкуса.";
    m10.price = [NSNumber numberWithDouble:1.1];
    m10.image = @"m10.png";
    [m10 addMenuToTypeObject:t2];
    
    Menu *m11 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m11.name = @"Zinger Toasted Twister";
    m11.desc = @"Свежа салата, пресни домати, сочно пилешко бонфиле мариновано по специална пикантна рецепта, вкусна тортила и всичко запечено на грил. Пикантен и различен.";
    m11.price = [NSNumber numberWithDouble:1.1];
    m11.image = @"m11.png";
    [m11 addMenuToTypeObject:t2];
    
    Menu *m12 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m12.name = @"";
    m12.desc = @"";
    m12.price = [NSNumber numberWithDouble:1.1];
    m12.image = @"m12.png";
    [m12 addMenuToTypeObject:t2];
    
    Menu *m13 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m13.name = @"Tower";
    m13.desc = @"Пухкаво сусамено хлебче, лек майонезен сос, салата, вкусно картофено кюфте, сирене ементал, кетчуп и 100% пилешко филе, приготвено по оригиналната KFC рецепта от 11 билки и подправки.";
    m13.price = [NSNumber numberWithDouble:1.1];
    m13.image = @"m13.png";
    [m13 addMenuToTypeObject:t2];
    
    Menu *m14 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m14.name = @"Zinger Tower";
    m14.desc = @"Пухкаво сусамено хлебче, лек майонезен сос, салата, вкусно картофено кюфте, сирене ементал, кетчуп и 100% пилешко филе мариновано в специална пикантна панировка.";
    m14.price = [NSNumber numberWithDouble:1.1];
    m14.image = @"m14.png";
    [m14 addMenuToTypeObject:t2];
    
    [t2 addTypeToMenu:[NSSet setWithObjects:m6, m7, m8, m9, m10, m11, m12, m13, m14, nil]];
    
    //garnishes
    Type *t3 = [NSEntityDescription insertNewObjectForEntityForName:@"Type" inManagedObjectContext:cdCtx];
    t3.name = @"Гарнитури";
    
    Menu *m16 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m16.name = @"Пържени картофки";
    m16.desc = @"Леко посолени, хрупкави и винаги топли, пържените картофки в KFC се предлагат в два размера: средни и големи. (средни-115g, големи-145g)";
    m16.price = [NSNumber numberWithDouble:1.1];
    m16.image = @"m16.png";
    [m16 addMenuToTypeObject:t3];
    
    Menu *m17 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m17.name = @"Картофено пюре";
    m17.desc = @"Вкусно картофено пюре и сос от грейви. Вървят ръка за ръка като Полковника и KFC. (малко – 100гр, голямо – 200гр)";
    m17.price = [NSNumber numberWithDouble:1.1];
    m17.image = @"m17.png";
    [m17 addMenuToTypeObject:t3];
    
    Menu *m18 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m18.name = @"Царевица";
    m18.desc = @"Царевицата в KFC е специален сорт сладка американска царевица, прочута със жълтия си цвят и млечния си вкус. След варене, ние в KFC я потапяме в масло, за да подчертаем нейния сладък и млечен вкус. (малка – 3”, голяма – 5,5”)";
    m18.price = [NSNumber numberWithDouble:1.1];
    m18.image = @"m18.png";
    [m18 addMenuToTypeObject:t3];
    
    Menu *m19 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m19.name = @"Пикантни картофки";
    m19.desc = @"При приготвянето на пикантните картофки в KFC ние използваме специално подбрани подправки и билки, които придават така специфичният им вкус и ги правят чудесно допълнение към всяко KFC меню. (150 гр.)";
    m19.price = [NSNumber numberWithDouble:1.1];
    m19.image = @"m19.png";
    [m19 addMenuToTypeObject:t3];
    
    Menu *m20 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m20.name = @"Салата Снежанка";
    m20.desc = @"Краставици, прясно изцедено кисело мляко, копър, чесън. (малка 90 гр., голяма 185 гр.)";
    m20.price = [NSNumber numberWithDouble:1.1];
    m20.image = @"m20.png";
    [m20 addMenuToTypeObject:t3];
    
    Menu *m21 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m21.name = @"Салата Колсло";
    m21.desc = @"Зеле, моркови, лук и вкусен специален салатен сос, правят салата колсло един от най-популярните KFC продукти. (малка - 90g, голяма – 185g)";
    m21.price = [NSNumber numberWithDouble:1.1];
    m21.image = @"m21.png";
    [m21 addMenuToTypeObject:t3];
    
    [t3 addTypeToMenu:[NSSet setWithObjects:m16, m17, m18, m19, m20, m21, nil]];
    
    //salads
    Type *t4 = [NSEntityDescription insertNewObjectForEntityForName:@"Type" inManagedObjectContext:cdCtx];
    t4.name = @"Салати";
    
    Menu *m22 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m22.name = @"Салата Цезар Оригинална рецепта";
    m22.desc = @"Свежа Айсберг салата и топли пилешки филенца с уникалния KFC вкус, домати и крутони, гарнирани със сирене пармезан и сос. (280 гр.)";
    m22.price = [NSNumber numberWithDouble:1.1];
    m22.image = @"m22.png";
    [m22 addMenuToTypeObject:t4];
    
    Menu *m23 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m23.name = @"Зингер салата";
    m23.desc = @"Свежа салата айсберг, топли пикантни пилешки филенца, пресни домати и хрупкава тортила. (285гр.)";
    m23.price = [NSNumber numberWithDouble:1.1];
    m23.image = @"m23.png";
    [m23 addMenuToTypeObject:t4];
    
    Menu *m24 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m24.name = @"Градинарска салата";
    m24.desc = @"Свеж микс от салата айсберг, домати, краставици и сладко-млечна царевица. (270 гр.)";
    m24.price = [NSNumber numberWithDouble:1.1];
    m24.image = @"m24.png";
    [m24 addMenuToTypeObject:t4];
    
    Menu *m25 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m25.name = @"Шейк салата";
    m25.desc = @"Прясна салата и микс от зеленчуци, предлагани в по-малък размер. Вкусно допълнение към всяко ваше меню. 160 гр.";
    m25.price = [NSNumber numberWithDouble:1.1];
    m25.image = @"m25.png";
    [m25 addMenuToTypeObject:t4];
    
    [t4 addTypeToMenu:[NSSet setWithObjects:m22, m23, m24, m25, nil]];
    
    //drinks
    Type *t5 = [NSEntityDescription insertNewObjectForEntityForName:@"Type" inManagedObjectContext:cdCtx];
    t5.name = @"Напитки";
    
    Menu *m26 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m26.name = @"Pepsi";
    m26.desc = @"";
    m26.price = [NSNumber numberWithDouble:1.1];
    m26.image = @"m26.png";
    [m26 addMenuToTypeObject:t5];
    
    Menu *m27 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m27.name = @"Pepsi 500ml";
    m27.desc = @"Бира Загорка наливна 400ml";
    m27.price = [NSNumber numberWithDouble:1.1];
    m27.image = @"m27.png";
    [m27 addMenuToTypeObject:t5];
    
    Menu *m28 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m28.name = @"Бира Загорка 500ml";
    m28.desc = @"";
    m28.price = [NSNumber numberWithDouble:1.1];
    m28.image = @"m28.png";
    [m28 addMenuToTypeObject:t5];
    
    Menu *m29 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m29.name = @"Бира Heineken 330 ml";
    m29.desc = @"";
    m29.price = [NSNumber numberWithDouble:1.1];
    m29.image = @"m29.png";
    [m29 addMenuToTypeObject:t5];
    
    [t5 addTypeToMenu:[NSSet setWithObjects:m26, m27, m28, m29, nil]];
    
    //desserts
    Type *t6 = [NSEntityDescription insertNewObjectForEntityForName:@"Type" inManagedObjectContext:cdCtx];
    t6.name = @"Десерти";
    
    Menu *m30 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m30.name = @"Чийзкейк";
    m30.desc = @"Приготвен по традиционна рецепта, чийзкейкът е едно от удоволствията към които можеш да се връщаш винаги: хрупкави бисквити потопени в масло, покрити с нежно крема сирене и гарнирани със сладко от боровинки. (малък – 140 гр.)";
    m30.price = [NSNumber numberWithDouble:1.1];
    m30.image = @"m30.png";
    [m30 addMenuToTypeObject:t6];
    
    [t6 addTypeToMenu:[NSSet setWithObject:m30]];
    
    //buckets
    Type *t7 = [NSEntityDescription insertNewObjectForEntityForName:@"Type" inManagedObjectContext:cdCtx];
    t7.name = @"Buckets";
    
    Menu *m31 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m31.name = @"2 Gether Bucket";
    m31.desc = @"2 п.пиле, 3 пик.крилца, 3 бонфиле, 2 топли гарнитури от един вид ";
    m31.price = [NSNumber numberWithDouble:10.99];
    m31.image = @"m31.png";
    [m31 addMenuToTypeObject:t7];
    
    Menu *m32 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m32.name = @"2 Gether Bucket HOT";
    m32.desc = @"14 крилца, 2 топли гарнитури от един вид ";
    m32.price = [NSNumber numberWithDouble:10.99];
    m32.image = @"m32.png";
    [m32 addMenuToTypeObject:t7];
    
    Menu *m33 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m33.name = @"Кофа 11:11";
    m33.desc = @"11 бонфилета, 11 пикантни крилца";
    m33.price = [NSNumber numberWithDouble:16.99];
    m33.image = @"m33.png";
    [m33 addMenuToTypeObject:t7];
    
    Menu *m34 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m34.name = @"30 Hot";
    m34.desc = @"30 пикантни крилца, 4 соса";
    m34.price = [NSNumber numberWithDouble:19.99];
    m34.image = @"m34.png";
    [m34 addMenuToTypeObject:t7];
    
    Menu *m35 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m35.name = @"20 Crispy";
    m35.desc = @"20 бонфилета, 4 соса";
    m35.price = [NSNumber numberWithDouble:19.99];
    m35.image = @"m35.png";
    [m35 addMenuToTypeObject:t7];
    
    Menu *m36 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m36.name = @"Bucket Mix";
    m36.desc = @"8 п.пиле, 16 пик.крилца";
    m36.price = [NSNumber numberWithDouble:24.99];
    m36.image = @"m36.png";
    [m36 addMenuToTypeObject:t7];
    
    Menu *m37 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m37.name = @"Picnic Bucket";
    m37.desc = @"8 п.пиле, 8 бонфилета, 8 пик.крилца";
    m37.price = [NSNumber numberWithDouble:27.99];
    m37.image = @"m37.png";
    [m37 addMenuToTypeObject:t7];
    
    [t7 addTypeToMenu:[NSSet setWithObjects:m31, m32, m33, m34, m35, m36, m37, nil]];
    
    //combos
    Type *t8 = [NSEntityDescription insertNewObjectForEntityForName:@"Type" inManagedObjectContext:cdCtx];
    t8.name = @"Комбинирани менюта";
    
    Menu *m38 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m38.name = @"Меню 3 Крила";
    m38.desc = @"3 пикантни крилца, малко картофено пюре и малка салата колсло.";
    m38.price = [NSNumber numberWithDouble:1.1];
    m38.image = @"m38.png";
    [m38 addMenuToTypeObject:t8];
    
    Menu *m39 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m39.name = @"Меню 5 Крила";
    m39.desc = @"5 пикантни крилца, малко картофено пюре и малка салата колсло.";
    m39.price = [NSNumber numberWithDouble:1.1];
    m39.image = @"m39.png";
    [m39 addMenuToTypeObject:t8];
    
    Menu *m40 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m40.name = @"Меню 8 Крила";
    m40.desc = @"8 пикантни крилца, малко картофено пюре и малка салата колсло.";
    m40.price = [NSNumber numberWithDouble:1.1];
    m40.image = @"m40.png";
    [m40 addMenuToTypeObject:t8];
    
    Menu *m41 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m41.name = @"Бургер меню";
    m41.desc = @"Филебургер или Зингер, малко картофено пюре, Pepsi 330 ml.";
    m41.price = [NSNumber numberWithDouble:1.1];
    m41.image = @"m41.png";
    [m41 addMenuToTypeObject:t8];
    
    Menu *m42 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m42.name = @"Tower меню";
    m42.desc = @"Тауър бургер, малко картофено пюре, Pepsi 330 ml.";
    m42.price = [NSNumber numberWithDouble:1.1];
    m42.image = @"m42.png";
    [m42 addMenuToTypeObject:t8];
    
    Menu *m43 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m43.name = @"Меню 2 парчета пиле";
    m43.desc = @"2 парчета пиле, малко картофено пюре, малка салата колсло";
    m43.price = [NSNumber numberWithDouble:1.1];
    m43.image = @"m43.png";
    [m43 addMenuToTypeObject:t8];
    
    Menu *m44 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m44.name = @"Меню 2 парчета пиле и 2 крилца";
    m44.desc = @"2 парчета пиле, 2 пикантни крилца, малко картофено пюре, малка салата колсло";
    m44.price = [NSNumber numberWithDouble:1.1];
    m44.image = @"m44.png";
    [m44 addMenuToTypeObject:t8];
    
    Menu *m45 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m45.name = @"3 Бонфиле меню";
    m45.desc = @"3 бонфилета, малко картофено пюре, малка салата колсло";
    m45.price = [NSNumber numberWithDouble:1.1];
    m45.image = @"m45.png";
    [m45 addMenuToTypeObject:t8];
    
    Menu *m46 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m46.name = @"5 Бонфиле меню";
    m46.desc = @"5 бонфилета, малко картофено пюре, малка салата колсло";
    m46.price = [NSNumber numberWithDouble:1.1];
    m46.image = @"m46.png";
    [m46 addMenuToTypeObject:t8];
    
    Menu *m47 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m47.name = @"8 Бонфиле меню";
    m47.desc = @"8 бонфилета, малко картофено пюре, малка салата колсло";
    m47.price = [NSNumber numberWithDouble:1.1];
    m47.image = @"m47.png";
    [m47 addMenuToTypeObject:t8];
    
    [t8 addTypeToMenu:[NSSet setWithObjects:m38, m39, m40, m41, m42, m43, m44, m45, m46, m47, nil]];
    
    //take aways
    Type *t9 = [NSEntityDescription insertNewObjectForEntityForName:@"Type" inManagedObjectContext:cdCtx];
    t9.name = @"Take Away Box Meals";
    
    Menu *m48 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m48.name = @"Chicken Box Meal";
    m48.desc = @"Парче пиле, 3 пикантни крилца, 2 бонфилета, голямо картофено пюре и малка царевица.";
    m48.price = [NSNumber numberWithDouble:1.1];
    m48.image = @"m48.png";
    [m48 addMenuToTypeObject:t9];
    
    Menu *m49 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m49.name = @"Fillet Burger Box Meal";
    m49.desc = @"Филебургер, парче пиле, голямо картофено пюре и малка царевица.";
    m49.price = [NSNumber numberWithDouble:1.1];
    m49.image = @"m49.png";
    [m49 addMenuToTypeObject:t9];
    
    Menu *m50 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m50.name = @"Zinger Burger Box Meal";
    m50.desc = @"Зингер, парче пиле, голямо картофено пюре и малка царевица.";
    m50.price = [NSNumber numberWithDouble:1.1];
    m50.image = @"m50.png";
    [m50 addMenuToTypeObject:t9];
    
    Menu *m51 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m51.name = @"Tower Burger Box Meal";
    m51.desc = @"Тауър, парче пиле, голямо картофено пюре и малка царевица.";
    m51.price = [NSNumber numberWithDouble:1.1];
    m51.image = @"m51.png";
    [m51 addMenuToTypeObject:t9];
    
    [t9 addTypeToMenu:[NSSet setWithObjects:m48, m49, m50, m51, nil]];
    
    //restaurants
    //Sofia
    City *c1 = [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:cdCtx];
    c1.name = @"София";
    
    Restaurant *r1 = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:cdCtx];
    r1.name = @"KFC Стамболийски";
    r1.address = @"Бул. „Александър Стамболийски”, 28";
    r1.workingTime = @"понеделник – неделя: 11 – 24 часа";
    r1.hasAirCond = [NSNumber numberWithBool:YES];
    r1.hasDelivery = [NSNumber numberWithBool:YES];
    r1.hasDunken = [NSNumber numberWithBool:NO];
    r1.hasKidsLanding = [NSNumber numberWithBool:NO];
    r1.hasKidsParties = [NSNumber numberWithBool:NO];
    r1.hasParking = [NSNumber numberWithBool:YES];
    r1.lat = [NSNumber numberWithFloat:42.697458];
    r1.lon = [NSNumber numberWithFloat:23.318095];
    [r1 addRestaurantToCityObject:c1];
    
    Restaurant *r2 = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:cdCtx];
    r2.name = @"KFC Гарибалди";
    r2.address = @"Площад „Гарибалди”, улица „Ангел Кънчев”, 2";
    r2.workingTime = @"понеделник – събота: 10 – 23 часа, неделя: 11 – 23 часа";
    r2.hasAirCond = [NSNumber numberWithBool:YES];
    r2.hasDelivery = [NSNumber numberWithBool:NO];
    r2.hasDunken = [NSNumber numberWithBool:NO];
    r2.hasKidsLanding = [NSNumber numberWithBool:NO];
    r2.hasKidsParties = [NSNumber numberWithBool:NO];
    r2.hasParking = [NSNumber numberWithBool:NO];
    r2.lat = [NSNumber numberWithFloat:42.693829];
    r2.lon = [NSNumber numberWithFloat:23.322381];
    [r2 addRestaurantToCityObject:c1];
    
    Restaurant *r3 = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:cdCtx];
    r3.name = @"KFC Лъвов мост";
    r3.address = @"Площад „Лъвов мост”, булевард „Сливница”, 172";
    r3.workingTime = @"понеделник – неделя: 11 - 22,30 часа";
    r3.hasAirCond = [NSNumber numberWithBool:YES];
    r3.hasDelivery = [NSNumber numberWithBool:YES];
    r3.hasDunken = [NSNumber numberWithBool:YES];
    r3.hasKidsLanding = [NSNumber numberWithBool:NO];
    r3.hasKidsParties = [NSNumber numberWithBool:YES];
    r3.hasParking = [NSNumber numberWithBool:NO];
    r3.lat = [NSNumber numberWithFloat:42.704413];
    r3.lon = [NSNumber numberWithFloat:23.324436];
    [r3 addRestaurantToCityObject:c1];
    
    Restaurant *r4 = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:cdCtx];
    r4.name = @"KFC Люлин";
    r4.address = @"Люлин VІІ микрорайон, булевард „Джавахарлал Неру”";
    r4.workingTime = @"понеделник - неделя: 10 – 22.30 часа";
    r4.hasAirCond = [NSNumber numberWithBool:YES];
    r4.hasDelivery = [NSNumber numberWithBool:YES];
    r4.hasDunken = [NSNumber numberWithBool:YES];
    r4.hasKidsLanding = [NSNumber numberWithBool:YES];
    r4.hasKidsParties = [NSNumber numberWithBool:YES];
    r4.hasParking = [NSNumber numberWithBool:YES];
    r4.lat = [NSNumber numberWithFloat:42.715142];
    r4.lon = [NSNumber numberWithFloat:23.252907];
    [r4 addRestaurantToCityObject:c1];
    
    Restaurant *r5 = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:cdCtx];
    r5.name = @"KFC CCS";
    r5.address = @"Булевард „Арсеналски”, City Center Sofia, етаж 3";
    r5.workingTime = @"понеделник – неделя: 10 – 22 часа";
    r5.hasAirCond = [NSNumber numberWithBool:YES];
    r5.hasDelivery = [NSNumber numberWithBool:NO];
    r5.hasDunken = [NSNumber numberWithBool:NO];
    r5.hasKidsLanding = [NSNumber numberWithBool:NO];
    r5.hasKidsParties = [NSNumber numberWithBool:NO];
    r5.hasParking = [NSNumber numberWithBool:YES];
    r5.lat = [NSNumber numberWithFloat:42.678271];
    r5.lon = [NSNumber numberWithFloat:23.320048];
    [r5 addRestaurantToCityObject:c1];
    
    Restaurant *r6 = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:cdCtx];
    r6.name = @"KFC Арена Младост";
    r6.address = @"Бизнес Парк, Младост 4ри, ет. 2 /food court/";
    r6.workingTime = @"понеделник - петък: 11 – 23 часа, събота, неделя: 10 - 23 ";
    r6.hasAirCond = [NSNumber numberWithBool:YES];
    r6.hasDelivery = [NSNumber numberWithBool:YES];
    r6.hasDunken = [NSNumber numberWithBool:NO];
    r6.hasKidsLanding = [NSNumber numberWithBool:NO];
    r6.hasKidsParties = [NSNumber numberWithBool:NO];
    r6.hasParking = [NSNumber numberWithBool:YES];
    r6.lat = [NSNumber numberWithFloat:42.626128];
    r6.lon = [NSNumber numberWithFloat:23.376074];
    [r6 addRestaurantToCityObject:c1];
    
    Restaurant *r7 = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:cdCtx];
    r7.name = @"KFC Сахаров";
    r7.address = @"Адрес: София, Младост 1, бул. Сахаров №25";
    r7.workingTime = @"всеки ден 10,30 - 22,30 часа";
    r7.hasAirCond = [NSNumber numberWithBool:YES];
    r7.hasDelivery = [NSNumber numberWithBool:YES];
    r7.hasDunken = [NSNumber numberWithBool:NO];
    r7.hasKidsLanding = [NSNumber numberWithBool:NO];
    r7.hasKidsParties = [NSNumber numberWithBool:YES];
    r7.hasParking = [NSNumber numberWithBool:NO];
    r7.lat = [NSNumber numberWithFloat:42.65458];
    r7.lon = [NSNumber numberWithFloat:23.370634];
    [r7 addRestaurantToCityObject:c1];
    
    Restaurant *r8 = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:cdCtx];
    r8.name = @"KFC Сердика център";
    r8.address = @"Булевард Ситняково, 48, Сердика център, етаж 2ри";
    r8.workingTime = @"понеделник - неделя - 10 - 22 часа";
    r8.hasAirCond = [NSNumber numberWithBool:YES];
    r8.hasDelivery = [NSNumber numberWithBool:NO];
    r8.hasDunken = [NSNumber numberWithBool:NO];
    r8.hasKidsLanding = [NSNumber numberWithBool:NO];
    r8.hasKidsParties = [NSNumber numberWithBool:NO];
    r8.hasParking = [NSNumber numberWithBool:YES];
    r8.lat = [NSNumber numberWithFloat:42.691911];
    r8.lon = [NSNumber numberWithFloat:23.354487];
    [r8 addRestaurantToCityObject:c1];
    
    Restaurant *r9 = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:cdCtx];
    r9.name = @"KFC The Mall";
    r9.address = @"Булевард Цариградско шосе, 115, The Mall, food court";
    r9.workingTime = @"понеделник - неделя - 10 - 22 часа";
    r9.hasAirCond = [NSNumber numberWithBool:YES];
    r9.hasDelivery = [NSNumber numberWithBool:NO];
    r9.hasDunken = [NSNumber numberWithBool:NO];
    r9.hasKidsLanding = [NSNumber numberWithBool:NO];
    r9.hasKidsParties = [NSNumber numberWithBool:NO];
    r9.hasParking = [NSNumber numberWithBool:YES];
    r9.lat = [NSNumber numberWithFloat:42.663859];
    r9.lon = [NSNumber numberWithFloat:23.378778];
    [r9 addRestaurantToCityObject:c1];
    
    [c1 addCityToRestaurant:[NSSet setWithObjects:r1, r2, r3, r4, r5, r6, r7, r8, r9, nil]];
    
    //Plovdiv
    City *c2 = [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:cdCtx];
    c2.name = @"Пловдив";
    
    Restaurant *r10 = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:cdCtx];
    r10.name = @"KFC Mall of Plovdiv";
    r10.address = @"Адрес: Пловдив, ул. Перущица № 8";
    r10.workingTime = @"неделя - сряда 10:00 - 22:00 часа четвъртък - събота 10:00 - 23:00 часа ";
    r10.hasAirCond = [NSNumber numberWithBool:YES];
    r10.hasDelivery = [NSNumber numberWithBool:NO];
    r10.hasDunken = [NSNumber numberWithBool:NO];
    r10.hasKidsLanding = [NSNumber numberWithBool:NO];
    r10.hasKidsParties = [NSNumber numberWithBool:NO];
    r10.hasParking = [NSNumber numberWithBool:YES];
    r10.lat = [NSNumber numberWithFloat:42.141506];
    r10.lon = [NSNumber numberWithFloat:24.718831];
    [r10 addRestaurantToCityObject:c2];
    
    [c2 addCityToRestaurant:[NSSet setWithObject:r10]];
    
    //Stara Zagora
    City *c3 = [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:cdCtx];
    c3.name = @"Стара Загора";
    
    Restaurant *r11 = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:cdCtx];
    r11.name = @"KFC Park Mall";
    r11.address = @"бул. Никола Петков, 25, ет.2 /food court/";
    r11.workingTime = @"10:00 – 22:00 часа";
    r11.hasAirCond = [NSNumber numberWithBool:YES];
    r11.hasDelivery = [NSNumber numberWithBool:YES];
    r11.hasDunken = [NSNumber numberWithBool:NO];
    r11.hasKidsLanding = [NSNumber numberWithBool:NO];
    r11.hasKidsParties = [NSNumber numberWithBool:NO];
    r11.hasParking = [NSNumber numberWithBool:YES];
    r11.lat = [NSNumber numberWithFloat:42.624636];
    r11.lon = [NSNumber numberWithFloat:25.396818];
    [r11 addRestaurantToCityObject:c3];
    
    [c3 addCityToRestaurant:[NSSet setWithObject:r11]];
    
    //Burgas
    City *c4 = [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:cdCtx];
    c4.name = @"Бургас";
    
    Restaurant *r12 = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:cdCtx];
    r12.name = @"KFC Бургас";
    r12.address = @"Бургас Плаза Мол, 2 ет. Ул. Транспортна";
    r12.workingTime = @"понеделник – четвъртък 10:00 - 21:00 петък – неделя 10:00 - 22:00";
    r12.hasAirCond = [NSNumber numberWithBool:YES];
    r12.hasDelivery = [NSNumber numberWithBool:YES];
    r12.hasDunken = [NSNumber numberWithBool:NO];
    r12.hasKidsLanding = [NSNumber numberWithBool:NO];
    r12.hasKidsParties = [NSNumber numberWithBool:NO];
    r12.hasParking = [NSNumber numberWithBool:YES];
    r12.lat = [NSNumber numberWithFloat:42.530362];
    r12.lon = [NSNumber numberWithFloat:27.457945];
    [r12 addRestaurantToCityObject:c4];
    
    [c4 addCityToRestaurant:[NSSet setWithObject:r12]];
    
    //Slynchev Bryag
    City *c5 = [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:cdCtx];
    c5.name = @"Слънчев Бряг";
    
    Restaurant *r13 = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:cdCtx];
    r13.name = @"KFC Royal Beach Mall";
    r13.address = @"КК Слънчев бряг, Изток кв. 20, Сексция G";
    r13.workingTime = @"понеделник – неделя: 10 - 22 часа";
    r13.hasAirCond = [NSNumber numberWithBool:YES];
    r13.hasDelivery = [NSNumber numberWithBool:NO];
    r13.hasDunken = [NSNumber numberWithBool:NO];
    r13.hasKidsLanding = [NSNumber numberWithBool:NO];
    r13.hasKidsParties = [NSNumber numberWithBool:NO];
    r13.hasParking = [NSNumber numberWithBool:NO];
    r13.lat = [NSNumber numberWithFloat:42.695337];
    r13.lon = [NSNumber numberWithFloat:27.710352];
    [r13 addRestaurantToCityObject:c5];
    
    [c5 addCityToRestaurant:[NSSet setWithObject:r13]];
}


@end
