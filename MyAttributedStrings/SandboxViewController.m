//
//  SandboxViewController.m
//  MyAttributedStrings
//
//  Created by Richard E Millet on 4/18/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "SandboxViewController.h"

@interface SandboxViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIStepper *selectedWordStepper;
@property (weak, nonatomic) IBOutlet UILabel *selectedWordLabel;

@end

@implementation SandboxViewController

- (void)addAttributesToLabel:(NSDictionary *)dict range:(NSRange)range {
	if (range.location != NSNotFound) {
		NSMutableAttributedString *mat = [self.label.attributedText mutableCopy];
		[mat addAttributes:dict range:range];
		self.label.attributedText = [mat copy];
	}
}

- (void)addAtrributesToSelectedWord:(NSDictionary *)dict {
	NSRange range = [[self.label.attributedText string] rangeOfString:[self selectedWord]];
	[self addAttributesToLabel:dict range:range];
}

- (IBAction)colorSelectedWord:(UIButton *)sender {
	UIColor *color = [sender backgroundColor];
	[self addAtrributesToSelectedWord:@{NSForegroundColorAttributeName : color}];
}

- (IBAction)underlineSelectedWord {
	[self addAtrributesToSelectedWord:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
}

- (IBAction)unUnderlineSelectedWord {
	[self addAtrributesToSelectedWord:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone)}];
}

- (IBAction)outlineSelectedWord {
	[self addAtrributesToSelectedWord:@{NSStrokeWidthAttributeName : @(3)}];
}

- (IBAction)unOutlineSelectedWord {
	[self addAtrributesToSelectedWord:@{NSStrokeWidthAttributeName : @(0)}];
}

- (IBAction)changeFont:(UIButton *)sender
{
    CGFloat fontSize = [UIFont systemFontSize];
	
    // next two lines added after lecture
    NSRange range = [[self.label.attributedText string] rangeOfString:[self selectedWord]];
    if (range.location != NSNotFound) {
        NSDictionary *attributes = [self.label.attributedText attributesAtIndex:range.location // was 0 in lecture
                                                                 effectiveRange:NULL];
        UIFont *existingFont = attributes[NSFontAttributeName];
        if (existingFont != nil) {
			fontSize = existingFont.pointSize;	
		}
    }
	
    UIFont *font = [sender.titleLabel.font fontWithSize:fontSize];
    [self addAtrributesToSelectedWord:@{ NSFontAttributeName : font }];
}

- (NSArray *)wordList {
	NSArray *result = @[@""];
	
	NSArray *wordList = [[self.label.attributedText string] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	if (wordList != nil) {
		result = wordList;
	}
	
	return result;
}

- (NSString *)selectedWord {
	NSString *result = nil;
	
	int index = (int)[self.selectedWordStepper value];
	result = [self wordList][index];
	
	return result;
}

- (IBAction)updateSelectedWord {
	self.selectedWordStepper.maximumValue = [[self wordList] count] - 1;
	self.selectedWordLabel.text = [self selectedWord];
}

//
// Framework method provided by XCode
//

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self updateSelectedWord];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
