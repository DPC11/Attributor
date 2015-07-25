//
//  AnalyzeViewController.m
//  Attributor
//
//  Created by 布白 on 15/7/24.
//  Copyright (c) 2015年 DPC. All rights reserved.
//

#import "AnalyzeViewController.h"

@interface AnalyzeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *colorCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlineCountLabel;

@end

@implementation AnalyzeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.textToAnalyze = [[NSAttributedString alloc] initWithString:@"Test" attributes:@{ NSForegroundColorAttributeName: [UIColor redColor], NSStrokeWidthAttributeName: @-3 }];
}

// Common pattern for updating UI
- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze {
    _textToAnalyze = textToAnalyze;
    if (self.view.window) {
        [self updateUI];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI {
    self.colorCountLabel.text = [NSString stringWithFormat:@"这段文本中有 %d 个有颜色的字符", (int)[[self textWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlineCountLabel.text = [NSString stringWithFormat:@"这段文本中有 %d 个加轮廓的字符", (int)[[self textWithAttribute:NSStrokeWidthAttributeName] length]];
}

- (NSAttributedString *)textWithAttribute:(NSString *)attribute {
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
    
    int index = 0;
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attribute atIndex:index effectiveRange:&range];
        if (value) {
            [text appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = (int)(range.location + range.length);
        } else {
            index++;
        }
    }
    
    return text;
}

@end
