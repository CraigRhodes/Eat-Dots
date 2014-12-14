//This file declares constants to be used all throughout the project.

typedef enum{
    white, green, blue, black, gray, yellow, purple
}Color;



//Banner stuff
#define kBannerHeight @"banner-height"
#define kBannerIsShowing @"banner-is-showing"
#define kBannerLoadedNotification @"banner-loaded"
#define kBannerNotLoadedNotification @"banner-not-loaded"

#define kDifficultyType @"difficulty-type"
#define kMainType @"main-type"


//Name keys
#define kWambaName @"wamba"
#define kGreenDotName @"green-dot"
#define kRedEnemyName @"red-enemy"
#define kMenuLabelName @"menu-label"
#define kTitleLabelName @"title-label"

/* Save keys */
#define kHighScoreKeyEasy @"high-score-easy"
#define kHighScoreKeyMedium @"high-score-medium"
#define kHighScoreKeyHard @"high-score-hard"
#define kFirstPlayKey @"first-play"

//Category bitmasks
#define wambaCategory 0x1 << 0 // 1 << 0
#define npcCategory 0x1 << 1 // 1 << 1
#define noCollisionCategory 0