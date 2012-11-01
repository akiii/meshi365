#define SEARCH_DISTANCE 0.005

#import "MSValueImageView.h"

@implementation MSValueImageView

- (NSString *) getDataFrom:(NSString *)url{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        nameArray = [NSMutableArray array];
        amenityArray = [NSMutableArray array];
        locationArray = [NSMutableArray array];
        
        //スクロールビューの設定
        self.frame = CGRectMake(0, 44, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen]applicationFrame].size.height - 44);
        self.backgroundColor = [UIColor colorWithRed:1.0 green:0.93 blue:0.8 alpha:1.0];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 800)];
        view.backgroundColor = self.backgroundColor;
        self.contentSize = view.bounds.size;
        
        int left_line = ([[UIScreen mainScreen] bounds].size.width-200)/2;
        self.cnt_stars = 3;
        
        //撮影画像表示
        im = [[UIImageView alloc] init];
        im.frame = CGRectMake(left_line, 30, 200, 200);
        [view addSubview:im];
        
        //評価星の表示
        for (int i = 0; i < kNumOfStars; i++) {
            star[i] = [UIButton buttonWithType:UIButtonTypeCustom];
            star[i].frame = CGRectMake(left_line + 30 * i, 240, 30, 30);
            star[i].tag = i;
            [self setBackgroundImageOfStarButton:star[i].tag];
            [star[i] addTarget:self action:@selector(tap_star0:) forControlEvents:UIControlEventTouchDown];
            [view addSubview:star[i]];
        }
        
        //食事名の設定
        UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(left_line-20, 280, 100, 30)];
        lbl1.backgroundColor = [UIColor clearColor];
        lbl1.text = @"Name:";
        [view addSubview:lbl1];
        meal_name = [[UITextField alloc] initWithFrame:CGRectMake(left_line-20, 310, 200, 28)];
        meal_name.borderStyle = UITextBorderStyleRoundedRect;
        [meal_name addTarget:self action:@selector(mealNameSave:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [view addSubview:meal_name];
        
        
        //コメント蘭の設定
        UILabel *lbl0 = [[UILabel alloc]initWithFrame:CGRectMake(left_line-20, 350, 100, 30)];
        lbl0.backgroundColor = [UIColor clearColor];
        lbl0.text = @"Comment:";
        [view addSubview:lbl0];
        
        comment = [[UITextView alloc] initWithFrame:CGRectMake(left_line-20, 380, 240, 120)];
        comment.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        comment.delegate = self;
        [view addSubview:comment];
        
        UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(left_line-20, 510, 100, 30)];
        lbl2.backgroundColor = [UIColor clearColor];
        lbl2.text = @"Place:";
        [view addSubview:lbl2];
        
        //店リスト表示
        [nameArray addObject:@"Place Data Loading..."];
        UITableView *table = [[UITableView alloc] init];
        table.frame = CGRectMake(left_line-20, 540, 240, 130);
        table.delegate = self;
        table.dataSource = self;
        [view addSubview:table];
        
        //位置情報の取得設定
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        [locationManager startUpdatingLocation];

        //店情報取得の非同期処理設定
        dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_queue_t q_main = dispatch_get_main_queue();
        
        dispatch_async(q_global, ^{
            while (longitude*latitude==0)
                [NSThread sleepForTimeInterval:0.1];
            
            NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[[self getDataFrom:[NSString stringWithFormat:@"http://api.openstreetmap.org/api/0.6/map?bbox=%f,%f,%f,%f",longitude-SEARCH_DISTANCE,latitude-SEARCH_DISTANCE,longitude+SEARCH_DISTANCE,latitude+SEARCH_DISTANCE]] dataUsingEncoding:NSUTF8StringEncoding]];
            [nameArray removeAllObjects];
            [nameArray addObject:@"Home"];
            parser.delegate = self;
            [parser parse];
            
            [locationManager stopUpdatingLocation];
            dispatch_async(q_main, ^{[table reloadData];});
        });
        
        //Add Social Button
        UIButton *twitterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        twitterBtn.frame = CGRectMake(left_line-25, 690, 120, 30);
        [twitterBtn setBackgroundImage:[UIImage imageNamed:@"Icon_Twitter.png"] forState:UIControlStateNormal];
        [twitterBtn addTarget:self action:@selector(twitter:) forControlEvents:UIControlEventTouchDown];
        [view addSubview:twitterBtn];
        UIButton *facebookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        facebookBtn.frame = CGRectMake(left_line+105, 690, 120, 30);
        [facebookBtn setBackgroundImage:[UIImage imageNamed:@"Icon_FaceBook.png"] forState:UIControlStateNormal];
        [facebookBtn addTarget:self action:@selector(facebook:) forControlEvents:UIControlEventTouchDown];
        [view addSubview:facebookBtn];
        
        //キャンセルボタン設定
        UIButton *cancel_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancel_button.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2-85, 740, 80, 30);
        [cancel_button setTitle:@"Cancel" forState:UIControlStateNormal];
        [cancel_button addTarget:self.delegate action:@selector(cancel_image:)
                forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:cancel_button];
        
        //保存ボタン設定
        UIButton *save_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        save_button.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2+5, 740, 80, 30);
        [save_button setTitle:@"Save" forState:UIControlStateNormal];
        [save_button addTarget:self.delegate action:@selector(save_image:)
              forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:save_button];
        
        //ビューの表示
        [self addSubview:view];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect{
    if(im.image==nil){
        CGRect image_rect;
        if(self.cameraImage.size.height>self.cameraImage.size.width)
                image_rect = CGRectMake(0, (self.cameraImage.size.height-self.cameraImage.size.width)/2,
                                   self.cameraImage.size.width,
                                   self.cameraImage.size.width);
        else    image_rect = CGRectMake((self.cameraImage.size.width-self.cameraImage.size.height)/2, 0,
                                     self.cameraImage.size.height,
                                     self.cameraImage.size.height);
        
        self.squareFoodPictureImage = [[MSFoodPictureImage alloc]
                                       initWithCGImage:CGImageCreateWithImageInRect([self.cameraImage CGImage], image_rect)];
        im.image = self.squareFoodPictureImage;
    }

}

-(void) tap_star0:(UIButton *)sender{
    self.cnt_stars = sender.tag + 1;
    for (int i = 0; i < kNumOfStars; i++) {
        [self setBackgroundImageOfStarButton:star[i].tag];
    }
    self.squareFoodPictureImage.foodPicture.starNum = self.cnt_stars;
}

- (void)setBackgroundImageOfStarButton:(int)tag{
    UIImage *backgroundImage;
    if(tag < self.cnt_stars)    backgroundImage = [UIImage imageNamed:@"star.png"];
    else                        backgroundImage = [UIImage imageNamed:@"starNonSelect.png"];

    [star[tag] setBackgroundImage:backgroundImage forState:UIControlStateNormal];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    [super touchesBegan:touches withEvent:event];
    if(!CGRectContainsPoint(comment.frame, location))
        [comment resignFirstResponder];
    if(!CGRectContainsPoint(meal_name.frame, location))
        [meal_name resignFirstResponder];
}

-(void) mealNameSave:(id)sender{
    self.meal_name = meal_name.text;
}
-(BOOL)textViewShouldEndEditing:(UITextView*)textView{
    self.comment_text = comment.text;
    return TRUE;
}

-(void)twitter:(id)sender{
}
-(void)facebook:(id)sender{
}
#pragma mark Restaurant List Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{return 1;}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{return [nameArray count];}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];	}
	
    cell.textLabel.font =  [UIFont systemFontOfSize:20];
    cell.textLabel.text = [nameArray objectAtIndex:indexPath.row];
    
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 選択状態の解除をします。
    self.place_name = [nameArray objectAtIndex:indexPath.row];
    self.place_name = [amenityArray objectAtIndex:indexPath.row-1];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{return 25;}

#pragma mark Restrant Information XML Parser
- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
attributes:(NSDictionary *)attributeDict {    
    if([elementName isEqualToString:@"node"]){
        node_flag = 1;
        node_latitude =  [attributeDict valueForKey:@"lat"];
        node_longitude =  [attributeDict valueForKey:@"lon"];
    }
    if(node_flag==1&&[elementName isEqualToString:@"tag"]){
        if([[attributeDict valueForKey:@"k"] isEqualToString:@"amenity"]){
            name_amenity = [attributeDict valueForKey:@"v"];
            if([name_amenity isEqualToString:@"cafe"]||[name_amenity isEqualToString:@"restaurant"]||[name_amenity isEqualToString:@"fast_food"])
            amenity_flag = 1;
            
        }
        if(amenity_flag==1&&[[attributeDict valueForKey:@"k"] isEqualToString:@"name"]){
            [nameArray addObject:[attributeDict valueForKey:@"v"]];
            [amenityArray addObject:name_amenity];
            [locationArray addObject:node_latitude];
            [locationArray addObject:node_longitude];
        }
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    if([elementName isEqualToString:@"node"]){
        node_flag = 0;
        amenity_flag = 0;
    }
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string {
}

- (void)parser:(NSXMLParser *)parser
parseErrorOccurred:(NSError *)parseError {
}

#pragma mark Location
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    longitude = newLocation.coordinate.longitude;
    latitude = newLocation.coordinate.latitude;
    
    //NSLog(@"longitude=%f,latitude=%f",longitude,latitude);
}


@end
