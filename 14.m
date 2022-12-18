#import <Foundation/Foundation.h>
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
int main (int argc, const char * argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    NSString *data = [ [NSString stringWithUTF8String:argv[1]] stringByReplacingOccurrencesOfString:@" -> "
                                     withString:@","];
    NSArray *lines = [data componentsSeparatedByString:@"|"];
    NSMutableArray *parseddata =  [[NSMutableArray alloc]init];
    int maxx = 0;
    int minx = 30000;
    int miny = 30000;
    int maxy = 0;
    NSArray *stringy;
    NSUInteger i = 0;
    for (id line in lines) {
    stringy = [line componentsSeparatedByString:@","];
        [parseddata addObject:[[NSMutableArray alloc]init]];
    NSUInteger  j = 0;
    for (id stringint in stringy) {
    [[parseddata objectAtIndex:i] addObject:  [NSNumber numberWithInteger:[stringint integerValue]]];
    if(j % 2 == 0){
        maxx = MAX( [stringint integerValue], maxx);
        minx = MIN( [stringint integerValue], minx);
    } else {
        maxy = MAX([stringint integerValue], maxy);
        miny = MIN([stringint integerValue], miny);        
    }
    j++;
    }
    i++;
    }
    int j = 0;
    NSMutableArray *prodata =  [[NSMutableArray alloc]init];
    for(i = 0; i <= maxy + 1; i++){
      [prodata addObject:[[NSMutableArray alloc]init]];  
      for(j = 0; j <= maxx- minx ; j++){
      [[prodata objectAtIndex:i] addObject:[NSNumber numberWithInteger:0]];
      }
    }
    [prodata addObject:[[NSMutableArray alloc]init]];  
    for(j = 0; j <= maxx- minx ; j++){
      [[prodata objectAtIndex:i] addObject:[NSNumber numberWithInteger:1]];
      }
    j = 0;
    int k = 0;
    for (i = 0; i < [parseddata count]; i++) {
        for (j = 0; j < [[parseddata objectAtIndex:i] count] - 2; j+= 2) {
        int pt1x = [[[parseddata objectAtIndex:i]objectAtIndex:j] intValue] - minx;
        int pt1y = [[[parseddata objectAtIndex:i]objectAtIndex:j+1] intValue] ;
        int pt2x = [[[parseddata objectAtIndex:i]objectAtIndex:j+2] intValue] - minx;
        int pt2y = [[[parseddata objectAtIndex:i]objectAtIndex:j+3] intValue] ;
        if(pt1x == pt2x){
            for(k = MIN(pt1y, pt2y); k <= MAX(pt1y, pt2y); k++){
               [[prodata objectAtIndex:k] replaceObjectAtIndex:pt1x withObject:[NSNumber numberWithInteger:1]];
            }
        }
        else if(pt1y == pt2y){
        for(k = MIN(pt1x, pt2x); k <= MAX(pt1x, pt2x); k++){
               [[prodata objectAtIndex:pt1y] replaceObjectAtIndex:k withObject:[NSNumber numberWithInteger:1]];
            }
        }
    }
    }
    int startpos = 500;
    int posx = startpos-minx;
    BOOL abyss = NO;
    BOOL donefalling = NO;
    int posy = 0;
    i = 0;
    while(!abyss){
    posx = startpos-minx;
    posy = 0;
    donefalling = NO;
    while(!donefalling){
        if(posx < 1){
            for(id row in prodata){
                [row insertObject:[NSNumber numberWithInteger:0] atIndex:0];
            }
            [[prodata lastObject] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:1]];
        posx++;
        startpos++;
        maxx++;
        }
        
        if(posx + 1 > (maxx - minx)){
            for(id row in prodata){
                [row addObject:[NSNumber numberWithInteger:0]];
            }
            [[prodata lastObject] removeLastObject];
            [[prodata lastObject] addObject:[NSNumber numberWithInteger:1]];
            maxx++;
        }
        if([[[prodata objectAtIndex:posy] objectAtIndex:posx] intValue] == 2){
            abyss = YES;
           NSLog(@"DONE: i", i);
            break;

        }
        if([[[prodata objectAtIndex:posy+1] objectAtIndex:posx] intValue] == 0){
        posy++;
        } else if([[[prodata objectAtIndex:posy+1] objectAtIndex:posx - 1] intValue] == 0){
        posy++;
        posx--;
        } else if([[[prodata objectAtIndex:posy+1] objectAtIndex:posx + 1] intValue] == 0){
        posy++;
        posx++;
        } else {
        [[prodata objectAtIndex:posy] replaceObjectAtIndex:posx withObject:[NSNumber numberWithInteger:2]];
            donefalling = YES;
        }
    }
    i++;
    }
    [pool drain];
    return 0;
}
