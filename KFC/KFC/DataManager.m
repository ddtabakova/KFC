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

@implementation DataManager

static dispatch_queue_t q;
static NSManagedObjectContext *cdCtx;
static NSManagedObjectModel *managedObjectModel;
static NSPersistentStoreCoordinator *persistentStoreCoordinator;
static NSUInteger currentNumberOfTracks;

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
    Menu *m1 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m1.name = @"Пиле Оригинална рецепта";
    m1.desc = @"100% сочно пилешко месо, готвено под налягане. Тайната на вкуса е в оригиналната рецепта от 11 билки и подправки. (гърди - мин. 130 гр., кълка/цяло крило - мин. 70 гр., бут - мин. 115 гр, филе - мин.115 гр.)";
    m1.price = [NSNumber numberWithDouble:1.1];
    m1.image = @"m1.png";
    
    Menu *m2 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m2.name = @"Пикантни крилца";
    m2.desc = @"Хрупкави и сочни, мариновани по специална пикантна рецепта. (3 крилца 75гр., 5 крилца 125 гр, 8 крилца 200)";
    m2.price = [NSNumber numberWithDouble:1.1];
    m2.image = @"m2.png";
    
    Menu *m3 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m3.name = @"Бонфиле";
    m3.desc = @"100% сочно бяло, пилешко месо. Приготвено по оригиналата рецепта на KFC, със сос по избор – майонеза, кетчуп или барбекю (BBQ). (3 бонфилета – 85g, 5 бонфилета – 135g, 8 бонфилета – 210g)";
    m3.price = [NSNumber numberWithDouble:1.1];
    m3.image = @"m3.png";
    
    Menu *m4 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m4.name = @"Пикантно пиле";
    m4.desc = @"Хрупкаво и сочно пиле в пикантна панировка. (кълка мин 70 гр., бут. мин 115 гр.)";
    m4.price = [NSNumber numberWithDouble:1.1];
    m4.image = @"m4.png";
    
    Menu *m5 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m5.name = @"Пикантно бонфиле";
    m5.desc = @"100% сочно бяло, пилешко месо. Мариновано по специална рецепта в пикантна марината, със сос по избор – майонеза, кетчуп или барбекю (BBQ). (3 бонфилета – 85g, 5 бонфилета – 135g, 8 бонфилета – 210g)";
    m5.price = [NSNumber numberWithDouble:1.1];
    m5.image = @"m5.png";
    
    //burgers
    Menu *m6 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m6.name = @"Bonburger";
    m6.desc = @"Сочно бонфиле, майонеза, хрупкава салата и хлебче. Бонбургер предлага така неповторимия KFC вкус на специална цена.";
    m6.price = [NSNumber numberWithDouble:1.1];
    m6.image = @"m6.png";
    
    Menu *m7 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m7.name = @"Fillet Burger";
    m7.desc = @"Направен от 100% сочно пилешко филе, винаги прясно приготвен по оригиналната рецепта от 11 билки и подправки, хрупкава салата, лек майонезен сос и хлебче по оригинална рецепта.";
    m7.price = [NSNumber numberWithDouble:1.1];
    m7.image = @"m7.png";
    
    Menu *m8 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m8.name = @"Боксмастър";
    m8.desc = @"Сочно пилешко филе, картофено кюфте, сирене чедър, свежи домати, салата, лек майонезен сос: всичко във вкусна тортила...повече от 300 гр удоволствие!";
    m8.price = [NSNumber numberWithDouble:1.1];
    m8.image = @"m8.png";
    
    Menu *m9 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m9.name = @"Zinger";
    m9.desc = @"100% сочно пилешко филе, мариновано в специалната ни пикантна панировка, прави вкуса на Зингера неустоим, хрупкава салата, лек майонезен сос и хлебче.";
    m9.price = [NSNumber numberWithDouble:1.1];
    m9.image = @"m9.png";
    
    Menu *m10 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m10.name = @"Toasted Twister";
    m10.desc = @"Свежа салата, пресни домати, сочно пилешко бонфиле, лек майонезен сос, и всичко това завито във вкусна тортила и запечено на грил. Изключително удобен начин да се насладиш на KFC вкуса.";
    m10.price = [NSNumber numberWithDouble:1.1];
    m10.image = @"m10.png";
    
    Menu *m11 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m11.name = @"Zinger Toasted Twister";
    m11.desc = @"Свежа салата, пресни домати, сочно пилешко бонфиле мариновано по специална пикантна рецепта, вкусна тортила и всичко запечено на грил. Пикантен и различен.";
    m11.price = [NSNumber numberWithDouble:1.1];
    m11.image = @"m11.png";
    
    Menu *m12 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m12.name = @"";
    m12.desc = @"";
    m12.price = [NSNumber numberWithDouble:1.1];
    m12.image = @"m12.png";
    
    Menu *m13 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m13.name = @"Tower";
    m13.desc = @"Пухкаво сусамено хлебче, лек майонезен сос, салата, вкусно картофено кюфте, сирене ементал, кетчуп и 100% пилешко филе, приготвено по оригиналната KFC рецепта от 11 билки и подправки.";
    m13.price = [NSNumber numberWithDouble:1.1];
    m13.image = @"m13.png";
    
    Menu *m14 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m14.name = @"Zinger Tower";
    m14.desc = @"Пухкаво сусамено хлебче, лек майонезен сос, салата, вкусно картофено кюфте, сирене ементал, кетчуп и 100% пилешко филе мариновано в специална пикантна панировка.";
    m14.price = [NSNumber numberWithDouble:1.1];
    m14.image = @"m14.png";
    
    //garnishes
    Menu *m16 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m16.name = @"Пържени картофки";
    m16.desc = @"Леко посолени, хрупкави и винаги топли, пържените картофки в KFC се предлагат в два размера: средни и големи. (средни-115g, големи-145g)";
    m16.price = [NSNumber numberWithDouble:1.1];
    m16.image = @"m16.png";
    
    Menu *m17 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m17.name = @"Картофено пюре";
    m17.desc = @"Вкусно картофено пюре и сос от грейви. Вървят ръка за ръка като Полковника и KFC. (малко – 100гр, голямо – 200гр)";
    m17.price = [NSNumber numberWithDouble:1.1];
    m17.image = @"m17.png";
    
    Menu *m18 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m18.name = @"Царевица";
    m18.desc = @"Царевицата в KFC е специален сорт сладка американска царевица, прочута със жълтия си цвят и млечния си вкус. След варене, ние в KFC я потапяме в масло, за да подчертаем нейния сладък и млечен вкус. (малка – 3”, голяма – 5,5”)";
    m18.price = [NSNumber numberWithDouble:1.1];
    m18.image = @"m18.png";
    
    Menu *m19 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m19.name = @"Пикантни картофки";
    m19.desc = @"При приготвянето на пикантните картофки в KFC ние използваме специално подбрани подправки и билки, които придават така специфичният им вкус и ги правят чудесно допълнение към всяко KFC меню. (150 гр.)";
    m19.price = [NSNumber numberWithDouble:1.1];
    m19.image = @"m19.png";
    
    Menu *m20 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m20.name = @"Салата Снежанка";
    m20.desc = @"Краставици, прясно изцедено кисело мляко, копър, чесън. (малка 90 гр., голяма 185 гр.)";
    m20.price = [NSNumber numberWithDouble:1.1];
    m20.image = @"m20.png";
    
    Menu *m21 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m21.name = @"Салата Колсло";
    m21.desc = @"Зеле, моркови, лук и вкусен специален салатен сос, правят салата колсло един от най-популярните KFC продукти. (малка - 90g, голяма – 185g)";
    m21.price = [NSNumber numberWithDouble:1.1];
    m21.image = @"m21.png";
    
    //salads
    Menu *m22 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m22.name = @"Салата Цезар Оригинална рецепта";
    m22.desc = @"Свежа Айсберг салата и топли пилешки филенца с уникалния KFC вкус, домати и крутони, гарнирани със сирене пармезан и сос. (280 гр.)";
    m22.price = [NSNumber numberWithDouble:1.1];
    m22.image = @"m22.png";
    
    Menu *m23 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m23.name = @"Зингер салата";
    m23.desc = @"Свежа салата айсберг, топли пикантни пилешки филенца, пресни домати и хрупкава тортила. (285гр.)";
    m23.price = [NSNumber numberWithDouble:1.1];
    m23.image = @"m23.png";
    
    Menu *m24 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m24.name = @"Градинарска салата";
    m24.desc = @"Свеж микс от салата айсберг, домати, краставици и сладко-млечна царевица. (270 гр.)";
    m24.price = [NSNumber numberWithDouble:1.1];
    m24.image = @"m24.png";
    
    Menu *m25 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m25.name = @"Шейк салата";
    m25.desc = @"Прясна салата и микс от зеленчуци, предлагани в по-малък размер. Вкусно допълнение към всяко ваше меню. 160 гр.";
    m25.price = [NSNumber numberWithDouble:1.1];
    m25.image = @"m25.png";
    
    //drinks
    Menu *m26 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m26.name = @"Pepsi";
    m26.desc = @"";
    m26.price = [NSNumber numberWithDouble:1.1];
    m26.image = @"m26.png";
    
    Menu *m27 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m27.name = @"Pepsi 500ml";
    m27.desc = @"Бира Загорка наливна 400ml";
    m27.price = [NSNumber numberWithDouble:1.1];
    m27.image = @"m27.png";
    
    Menu *m28 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m28.name = @"Бира Загорка 500ml";
    m28.desc = @"";
    m28.price = [NSNumber numberWithDouble:1.1];
    m28.image = @"m28.png";
    
    Menu *m29 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m29.name = @"Бира Heineken 330 ml";
    m29.desc = @"";
    m29.price = [NSNumber numberWithDouble:1.1];
    m29.image = @"m29.png";
    
    //desserts
    Menu *m30 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m30.name = @"Чийзкейк";
    m30.desc = @"Приготвен по традиционна рецепта, чийзкейкът е едно от удоволствията към които можеш да се връщаш винаги: хрупкави бисквити потопени в масло, покрити с нежно крема сирене и гарнирани със сладко от боровинки. (малък – 140 гр.)";
    m30.price = [NSNumber numberWithDouble:1.1];
    m30.image = @"m30.png";
    
    //buckets
    Menu *m31 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m31.name = @"2 Gether Bucket";
    m31.desc = @"2 п.пиле, 3 пик.крилца, 3 бонфиле, 2 топли гарнитури от един вид ";
    m31.price = [NSNumber numberWithDouble:10.99];
    m31.image = @"m31.png";
    
    Menu *m32 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m32.name = @"2 Gether Bucket HOT";
    m32.desc = @"14 крилца, 2 топли гарнитури от един вид ";
    m32.price = [NSNumber numberWithDouble:10.99];
    m32.image = @"m32.png";
    
    Menu *m33 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m33.name = @"Кофа 11:11";
    m33.desc = @"11 бонфилета, 11 пикантни крилца";
    m33.price = [NSNumber numberWithDouble:16.99];
    m33.image = @"m33.png";
    
    Menu *m34 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m34.name = @"30 Hot";
    m34.desc = @"30 пикантни крилца, 4 соса";
    m34.price = [NSNumber numberWithDouble:19.99];
    m34.image = @"m34.png";
    
    Menu *m35 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m35.name = @"20 Crispy";
    m35.desc = @"20 бонфилета, 4 соса";
    m35.price = [NSNumber numberWithDouble:19.99];
    m35.image = @"m35.png";
    
    Menu *m36 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m36.name = @"Bucket Mix";
    m36.desc = @"8 п.пиле, 16 пик.крилца";
    m36.price = [NSNumber numberWithDouble:24.99];
    m36.image = @"m36.png";
    
    Menu *m37 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m37.name = @"Picnic Bucket";
    m37.desc = @"8 п.пиле, 8 бонфилета, 8 пик.крилца";
    m37.price = [NSNumber numberWithDouble:27.99];
    m37.image = @"m37.png";
    
    //combos
    Menu *m38 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m38.name = @"Меню 3 Крила";
    m38.desc = @"3 пикантни крилца, малко картофено пюре и малка салата колсло.";
    m38.price = [NSNumber numberWithDouble:1.1];
    m38.image = @"m38.png";
    
    Menu *m39 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m39.name = @"Меню 5 Крила";
    m39.desc = @"5 пикантни крилца, малко картофено пюре и малка салата колсло.";
    m39.price = [NSNumber numberWithDouble:1.1];
    m39.image = @"m39.png";
    
    Menu *m40 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m40.name = @"Меню 8 Крила";
    m40.desc = @"8 пикантни крилца, малко картофено пюре и малка салата колсло.";
    m40.price = [NSNumber numberWithDouble:1.1];
    m40.image = @"m40.png";
    
    Menu *m41 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m41.name = @"Бургер меню";
    m41.desc = @"Филебургер или Зингер, малко картофено пюре, Pepsi 330 ml.";
    m41.price = [NSNumber numberWithDouble:1.1];
    m41.image = @"m41.png";
    
    Menu *m42 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m42.name = @"Tower меню";
    m42.desc = @"Тауър бургер, малко картофено пюре, Pepsi 330 ml.";
    m42.price = [NSNumber numberWithDouble:1.1];
    m42.image = @"m42.png";
    
    Menu *m43 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m43.name = @"Меню 2 парчета пиле";
    m43.desc = @"2 парчета пиле, малко картофено пюре, малка салата колсло";
    m43.price = [NSNumber numberWithDouble:1.1];
    m43.image = @"m43.png";
    
    Menu *m44 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m44.name = @"Меню 2 парчета пиле и 2 крилца";
    m44.desc = @"2 парчета пиле, 2 пикантни крилца, малко картофено пюре, малка салата колсло";
    m44.price = [NSNumber numberWithDouble:1.1];
    m44.image = @"m44.png";
    
    Menu *m45 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m45.name = @"3 Бонфиле меню";
    m45.desc = @"3 бонфилета, малко картофено пюре, малка салата колсло";
    m45.price = [NSNumber numberWithDouble:1.1];
    m45.image = @"m45.png";
    
    Menu *m46 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m46.name = @"5 Бонфиле меню";
    m46.desc = @"5 бонфилета, малко картофено пюре, малка салата колсло";
    m46.price = [NSNumber numberWithDouble:1.1];
    m46.image = @"m46.png";
    
    Menu *m47 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m47.name = @"8 Бонфиле меню";
    m47.desc = @"8 бонфилета, малко картофено пюре, малка салата колсло";
    m47.price = [NSNumber numberWithDouble:1.1];
    m47.image = @"m47.png";
    
    //take aways
    Menu *m48 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m48.name = @"Chicken Box Meal";
    m48.desc = @"Парче пиле, 3 пикантни крилца, 2 бонфилета, голямо картофено пюре и малка царевица.";
    m48.price = [NSNumber numberWithDouble:1.1];
    m48.image = @"m48.png";    
    
    Menu *m49 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m49.name = @"Fillet Burger Box Meal";
    m49.desc = @"Филебургер, парче пиле, голямо картофено пюре и малка царевица.";
    m49.price = [NSNumber numberWithDouble:1.1];
    m49.image = @"m49.png";
    
    Menu *m50 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m50.name = @"Zinger Burger Box Meal";
    m50.desc = @"Зингер, парче пиле, голямо картофено пюре и малка царевица.";
    m50.price = [NSNumber numberWithDouble:1.1];
    m50.image = @"m50.png";
    
    Menu *m51 = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:cdCtx];
    m51.name = @"Tower Burger Box Meal";
    m51.desc = @"Тауър, парче пиле, голямо картофено пюре и малка царевица.";
    m51.price = [NSNumber numberWithDouble:1.1];
    m51.image = @"m51.png";
    
}


@end
