//
//  TestData.m
//  RemediosCaseros
//
//  Created by User on 3/21/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import "TestData.h"
#import "AppDelegate.h"
#import "Categoria.h"
#import "Remedio.h"
#import "Glosario.h"


@implementation TestData
@synthesize addingManagedObjectContext,managedObjectContext;

-(void)createData
{
    //Obtener Contexto

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    managedObjectContext = appDelegate.managedObjectContext;
    
    // crear categoria
    Categoria *categoria1=[NSEntityDescription insertNewObjectForEntityForName:@"Categoria" inManagedObjectContext:managedObjectContext];
    categoria1.titulo=@"Salud";
    
    Categoria *categoria2=[NSEntityDescription insertNewObjectForEntityForName:@"Categoria" inManagedObjectContext:managedObjectContext];
    categoria2.titulo=@"Hogar";
    
    Categoria *categoria3=[NSEntityDescription insertNewObjectForEntityForName:@"Categoria" inManagedObjectContext:managedObjectContext];
    categoria3.titulo=@"Belleza";
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }

    
    
}
@end
