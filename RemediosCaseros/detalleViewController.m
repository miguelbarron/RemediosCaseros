//
//  detalleViewController.m
//  RemediosCaseros
//
//  Created by User on 3/26/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import "detalleViewController.h"
#import "Remedios.h"
//#import "Imagen.h"
#import "AppDelegate.h"
#import "twitter/twitter.h"
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


@implementation detalleViewController
@synthesize imagenRemedio;
@synthesize ingredientesRemedios;
@synthesize preparacionRemedio;
@synthesize svView;
@synthesize remedio;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
       
    //compartirButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(favorito:)];
    UIImage *imagenCompartir=[UIImage imageNamed:@"icono_compartir_detalleremedio.png"];
    compartirButton = [[UIBarButtonItem alloc] initWithImage:imagenCompartir style:UIBarButtonItemStyleBordered target:self action:@selector(compartir:)];
    self.navigationItem.rightBarButtonItem = compartirButton;
    [compartirButton release]; 
    
    [self.svView setContentSize:CGSizeMake(100,500)];
//    Imagen *imrem=remedio.imagen;
//    NSString *direccionImagen=imrem.imagenThumb;
    NSString *direccionImagen=remedio.imagenThumb;
    imagenRemedio.image=[UIImage imageNamed:direccionImagen];   
    
    self.title=remedio.nombreRemedio;
    ingredientesRemedios.text=remedio.ingredientes;
    preparacionRemedio.text=remedio.preparacion;
    

   
 
    
}
- (void)viewDidUnload
{
    [self setImagenRemedio:nil];
    [self setIngredientesRemedios:nil];
    [self setPreparacionRemedio:nil];
    [self setSvView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [imagenRemedio release];
    [ingredientesRemedios release];
    [preparacionRemedio release];
    [svView release];
    [super dealloc];
}

-(void)compartir:(id)sender{
    NSLog(@"compartir Remedio");
    
    [FBM logged];    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0")) {
        [self compartirIos5];
    }
    if (SYSTEM_VERSION_LESS_THAN(@"5.0")) {
        [self compartirIos4];
    }
}

-(void)newFeedTwitter:(NSMutableDictionary *)Dic
{
    TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
    
    
    //Customize the tweet sheet here
    //Add a tweet message
    [tweetSheet setInitialText:[Dic objectForKey:@"title"]];
    
    //Add an image
    NSLog(@"imagen %@",[Dic objectForKey:@"picture"]);//
    NSURL *url=[NSURL URLWithString:[Dic objectForKey:@"picture"]];
    NSData *data=[NSData dataWithContentsOfURL:url];
    [tweetSheet addImage:[UIImage imageWithData:data]];
    
    //Add a link
    if ([Dic objectForKey:@"link"]) {
        NSString *url = [Dic objectForKey:@"link"];
        
        //Don't worry, Twitter will handle turning this into a t.co link
        [tweetSheet addURL:[NSURL URLWithString:url]];
        
    }
    
    
    //Set a blocking handler for the tweet sheet
    tweetSheet.completionHandler = ^(TWTweetComposeViewControllerResult result){
        [self dismissModalViewControllerAnimated:YES];
    };
    //Show the tweet sheet!
    [self presentModalViewController:tweetSheet animated:YES];
    //[[SSAppDelegate sharedAppDelegate] hideTabBar:YES];       
    
    
    
    
}

-(void)compartirIos5
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Compartir en:" delegate:self
                                                   cancelButtonTitle:nil
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"Facebook", @"Twitter",@"Correo Electrónico",nil];
    
    [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.cancelButtonIndex = actionSheet.numberOfButtons-1;
    
    /*
     [actionSheet addButtonWithTitle:@"Facebook"];
     [actionSheet addButtonWithTitle:@"Twitter"];
     [actionSheet addButtonWithTitle:@"E-mail"];
     */ 
    
    
    
    [actionSheet showFromBarButtonItem:compartirButton animated:YES];
    [actionSheet release];
}

-(void)compartirIos4
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Compartir en:" delegate:self
                                                   cancelButtonTitle:@"Cancel"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"Facebook",@"Correo Electrónico",nil];
    
    /*
     if(_facebookName !=nil){
     [actionSheet addButtonWithTitle:@"Más..."];
     }*/
    /* [actionSheet addButtonWithTitle:@"Twitter"];
     [actionSheet addButtonWithTitle:@"E-mail"];
     */ 
    
    
    
    [actionSheet showFromBarButtonItem:compartirButton animated:YES];
    [actionSheet release];
    
    
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0")) {
        
        if ([actionSheet.title isEqualToString:@"Mas"]) {
            if (buttonIndex == 0) 
            {
                //   [_session logout];
                
            }
            
            
            
            else if (buttonIndex == 1)
            {
            }
            
        }
        
        
        
        else{ 
            if ([actionSheet.title isEqualToString:@"Compartir en:"]) {
                
                
                if (buttonIndex == 0) 
                {
                    NSLog(@"FBpost");
                    [self postFB];
                    
                }
                
                
                else if (buttonIndex == 1)
                {
                    [self newFeedTwitter:[self contenidoInfo]];  
                }
                
                
                else if (buttonIndex == 2) 
                {
                    [self sendEmail];
                    
                    
                }
                
                else if (buttonIndex == 3) 
                {
                    //  if(_facebookName !=nil){
                    
                    //    [self more];
                    // }
                    
                }
                
                
            }
        }
    }
    
    else {
        if (buttonIndex == 0) 
        {
            NSLog(@"fbPOst");
            [self postFB];
            
        }
        
        
        else if (buttonIndex == 1)
        {
            //[self sendEmail];
        }
    }
} 






-(void)sendEmail2:(NSMutableDictionary *)dic
{
    NSLog(@"Dic %@",[dic description]);
    if ([MFMailComposeViewController canSendMail])
    {
        
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:[dic objectForKey:@"title"]];
        
        if ([dic objectForKey:@"picture"]) {
            
            id path = [dic objectForKey:@"picture"];
            NSURL *url = [NSURL URLWithString:path];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *img = [[UIImage alloc] initWithData:data];
            
            NSData *imageData = UIImagePNGRepresentation(img);
            [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"Image"];	
            
        }
        
        NSMutableString* strMessage = [[NSMutableString alloc] init];	
        [strMessage appendString:[NSString stringWithFormat:@"<font face=\"helvetica\"><center><b>%@</b></center></font><font face=\"helvetica\"><br>%@",[dic objectForKey:@"title"],[dic objectForKey:@"description"]]];
        
        NSString *emailBody =  strMessage;
        [mailer setMessageBody:emailBody isHTML:YES];
        
        // only for iPad
        // mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        
        [self presentModalViewController:mailer animated:YES];
        
        [mailer release];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure" 
                                                        message:@"Your device doesn't support the composer sheet" 
                                                       delegate:nil 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
			break;
		default:
			NSLog(@"Mail not sent");
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark facebook

-(NSMutableDictionary*)contenidoInfo
{
    
    
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    
    [param setObject:@"http://neostar.org/test/lavilla_fb.png" forKey:@"picture"];
    
    
    
    [param setObject:@"www.remedioscaseros.com.mx" forKey:@"link"];
    
    
    //[param setObject:@"http://cache2.allpostersimages.com/p/LRG/10/1058/HVWL000Z/posters/morrow-anthony-cafe-capuchino.jpg" forKey:@"picture"];
    
    if (remedio.nombreRemedio) {
        [param setObject:remedio.nombreRemedio forKey:@"title"];
    }
    
    if (remedio.preparacion ) {
        
               [param setObject:remedio.preparacion forKey:@"description"];
    }
    
    [param setObject:@"Escriba algun Comentario" forKey:@"message"];
    NSLog(@"Detalle Cartelera : %@", [param description]);
    return param;   
}
-(void)sendEmail
{
    
    [self sendEmail2:[self contenidoInfo]];
    
}
-(void)postFB
{
    FacebookMethods *fb = [FacebookMethods sharedInstance];
    [fb fbSetId];
    [fb newFeed:[self contenidoInfo]];
    
}



@end
