//
//  CreaterFormViewModel.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 27/4/22.
//

import Foundation
import Combine

final class CreaterViewModel: ObservableObject {
    
    weak var textView: CreaterTextView?

    @Published var song = Song()
    @Published var showForm = false
    
    init() {
        setupSubscriptions()
    }
    
    func validate() {
        showForm = song.hasNotFilledForm
    }
    
    private var subscriptions = Set<AnyCancellable>()
    private func setupSubscriptions() {
        $song
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .compactMap{$0}
            .sink { [weak self] song in
                self?.textView?.set(string: song.rawText)
            }
            .store(in: &subscriptions)
    }
}

extension Song {
    
    var hasNotFilledForm: Bool { title.isWhitespace || artist.isWhitespace }
    var canSave: Bool { !hasNotFilledForm && !rawText.isWhitespace }
    
    static let hotelCalifornia: Song = {
        var x = Song(rawText: FormatIdentifier.process(hotelCaliforniaText))
        x.title = "Hotel California"
        x.artist = "The Eaglses"
        return x
    }()
    static let myanmar: Song = {
        var x = Song(rawText: withChords)
        x.title = "ကမ္ဘာမကျေ"
        x.artist = "တို့ဘိုးဘွား"
        return x
    }()
}

let withChords = """
{title: ကမ္ဘာမကျေ မြန်မာပြည်}
{artist: များလူခပ်သိမ်း}
{key: C}

[C] [Am] [F] [G]
[C]တရားမျှတ [Am]လွတ်လပ်ခြင်းနဲ့မသွေ၊
တို့ပြည်၊ [F]တို့မြေ၊[G]
[C]များလူခပ်သိမ်း၊ [Am]ငြိမ်းချမ်းစေဖို့၊[G]
ခွင့်တူညီမျှ၊ [F]ဝါဒဖြူစင်တဲ့ပြည်၊[F][G]
တို့ပြည်၊ [C]တို့မြေ၊
ပြည်[Am]ထောင်စုအမွေ၊ [G]အမြဲတည်တံ့စေ၊[F][Am]
[C]အဓိဋ္ဌာန်ပြုပေ၊ [G]ထိန်း[F]သိမ်းစို့လေ[Am]

ကမ္ဘာမကျေ၊[G] မြန်မာပြည်၊[Am][C][G]
[Am]တို့ဘိုးဘွား [C]အမွေစစ်မို့ [G]ချစ်မြတ်နိုးပေ။
ပြည်ထောင်စုကို [Dm]အသက်ပေးလို့ [Am]တို့ကာကွယ်မလေ၊[C][F][G]
ဒါတို့ပြည် [An]ဒါတို့မြေ [C]တို့ပိုင်နက်မြေ။[F]
[C]တို့ပြည် တို့မြေ [F]အကျိုးကို [G]ညီညာစွာတို့တစ်တွေ[Am]
[F]ထမ်းဆောင်ပါစို့လေ [G]တို့တာဝန်ပေ အဖိုးတန်မြေ။[C]

[C][Am][F][G]
[C]တရားမျှတ [Am]လွတ်လပ်ခြင်းနဲ့မသွေ၊
တို့ပြည်၊ [F]တို့မြေ၊[G]
[C]များလူခပ်သိမ်း၊ [Am]ငြိမ်းချမ်းစေဖို့၊[G]
ခွင့်တူညီမျှ၊ [F]ဝါဒဖြူစင်တဲ့ပြည်၊[F][G]
တို့ပြည်၊ [C]တို့မြေ၊
ပြည်[Am]ထောင်စုအမွေ၊ [G]အမြဲတည်တံ့စေ၊[F][Am]
[C]အဓိဋ္ဌာန်ပြုပေ၊ [G]ထိန်း[F]သိမ်းစို့လေ[Am]

ကမ္ဘာမကျေ၊[G] မြန်မာပြည်၊[Am][C][G]
[Am]တို့ဘိုးဘွား [C]အမွေစစ်မို့ [G]ချစ်မြတ်နိုးပေ။
ပြည်ထောင်စုကို [Dm]အသက်ပေးလို့ [Am]တို့ကာကွယ်မလေ၊[C][F][G]
ဒါတို့ပြည် [An]ဒါတို့မြေ [C]တို့ပိုင်နက်မြေ။[F]
[C]တို့ပြည် တို့မြေ [F]အကျိုးကို [G]ညီညာစွာတို့တစ်တွေ[Am]
[F]ထမ်းဆောင်ပါစို့လေ [G]တို့တာဝန်ပေ အဖိုးတန်မြေ။[C]
"""
let hotelCaliforniaText = """
Am                        E7
On a dark desert highway, cool wind in my hair
G                     D
Warm smell of colitas rising up through the air
F                         C
Up ahead in the distance, I saw a shimmering light
Dm
My head grew heavy and my sight grew dim,
E
I had to stop for the night

[Verse 2]
Am                              E7
There she stood in the doorway, I heard the mission bell
G
And I was thinking to myself
             D
This could be heaven or this could be hell
F                         C
Then she lit up a candle, and she showed me the way
Dm
There were voices down the corridor,
E7
I thought I heard them say...

[Chorus]
F                         C
Welcome to the Hotel California
      E7                                         Am
Such a lovely place (such a lovely place), such a lovely face
F                                       C
There's plenty of room at the Hotel California
   Dm                                       E7
Any time of year, (any time of year) You can find it here...

[Verse 3]
Am                           E7
Her mind is Tiffany twisted, She got the Mercedes bends
G                                   D
She got a lot of pretty pretty boys that she calls friends
F                                 C
How they danced in the courtyard, sweet summer sweat
Dm                      E7
Some dance to remember, some dance to forget

[Verse 4]
Am                           E7
So I called up the captain; "Please bring me my wine" (he said)
G                                     D
"We haven't had that spirit here since 1969"
F                                       C
And still those voices are calling from far away
Dm
Wake you up in the middle of the night
E7
Just to hear them say...

[Chorus]
F                         C
Welcome to the Hotel California
      E7                                         Am
Such a lovely place (such a lovely place), such a lovely face
       F                             C
They're livin' it up at the Hotel California
      Dm                                               E7
What a nice surprise (what a nice surprise), bring your alibis

[Verse 5]
Am                      E7
Mirrors on the ceiling, the pink champagne on ice (and she said)
G                               D
We are all just prisoners here, of our own device
F                             C
And in the master's chambers, they gathered for the feast
Dm
They stab it with their steely knives, but they
E7
Just can't kill the beast

[Verse 6]
Am                           E7
Last thing I remember, I was running for the door
G                                     D
I had to find the passage back to the place I was before
F                                   C
"Relax" said the night man, "we are programmed to receive,
Dm
You can check out any time you like
E7
But you can never leave"

[Outro]
Am E7 G D7 F C Dm E7  x5
"""

