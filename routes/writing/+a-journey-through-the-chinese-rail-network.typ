#import "@preview/html-shim:0.1.0": *

#show: html-shim.with(
  date: datetime(day: 6, year: 2025, month: 8),
  location: "Shanghai, China",
  title: "From Shanghai to Hong Kong: on the Chinese transit network",
  enable-comments: true,
  subtitle: "A journey from Shanghai to (eventually) Hong Kong International Airport by rail, told in pictures.",
)

#let getResource(uri) = {
  "https://cdn.youwen.dev/shanghai-to-hong-kong-resources/" + uri
}

#webimg(
  getResource("aesthetic-train-platform-shot.jpg"),
  "scenic shot of the shanghai hongqiao railway station at night, with a high speed rail car in frame",
)

In Leg 1, we head to the city of Changsha, to visit family. A few days later,
in Leg 2, we depart from Changsha to Hong Kong to catch a flight to San
Francisco.

= Leg 1

#webimg(
  getResource("changsha-rail-route.jpg"),
  "screenshot of apple maps showing the route of leg 1",
  caption: "The route, roughly an 11 hour drive stretching 651 kilometers. Distance-wise, it’s a bit longer than San Francisco to Los Angeles, which takes 6-7 hours on a good day.",
)

#smallcaps(all: true)[Shanghai, 10:25---]Our objective: the city of Changsha,
in Hunan Province. We begin at my apartment in Shanghai’s
residential district. We’ll take the metro to Shanghai Hongqiao Railway Station (上海虹桥火车站), the primary high-speed rail hub in the area.

First, an ~8 minute walk to the nearest metro station, Hongxin Road Station (虹莘路站), on Line 12. From this point until our destination, we won’t ever have to leave the grounds of a metro/railway station.

#webimg(
  getResource("hongxin-lu-zhan.jpg"),
  "hongxin road station entrance",
  caption: "Station entrance",
)

#webimg(
  getResource("shanghai-metro-fare-gates.jpg"),
  "metro fare gates",
  caption: "Fare gates. Shanghai metro accepts all major Western credit cards, China UnionPay, WeChat/Alipay QR codes, and China T-Union transit cards (physical and Apple Wallet).",
)

I tap my phone on the fare gate card reader and my Shanghai Public Transit Card
in Apple Wallet activates. Most people scan transit payment QR codes from
mobile apps instead on the fare gate QR scanner instead, but I find this far
less convenient.

#webimg(
  getResource(
    "shangha-metro-platform.jpg",
  ),
  "station platform",
)


#webimg(
  getResource("shanghai-metro-car-interior.jpg"),
  "interior of shanghai metro car",
  caption: "The train interiors are clean and spacious.",
)


After a few stops on Line 12, we get off and internally transfer onto Line 3.

#webimg(
  getResource("shanghai-metro-raised-platform.jpg"),
  "line 3 platform",
  caption: "Line 3 is one of Shanghai’s older lines. The transfer station was grade-separated and raised above ground, reminiscient of BART stations like Walnut Creek in the Bay.",
)

Line 3 quickly moves from above-ground into an underground subway tunnel, where
I shortly transfer to Line 4---terminal station, Hongqiao Railway Station.
After around 20 minutes on Line 4, I arrive.

In total, the journey on the metro took an hour flat. Driving on the other hand
usually takes 30 minutes with moderate traffic, but ride-hailing is far more
expensive (RMB\$40--60 #sym.approx US\$5-7) and prone to sudden influxes of
traffic. In contrast, the metro costs just (RMB\$6 #sym.approx US\$0.84), and
guarantees you’ll arrive on time.

(Obviously, these prices are both pocket change for Americans---think of each RMB as one USD to get a rough sense of how an average resident views the situation.)

#webimg(
  getResource("shanghai-hongqiao-rail-route.jpg"),
  "metro route to hongqiao railway station",
  caption: "The route I took. Notice how I had to travel towards the city center to take the radial Line 4 in order to get onto the right line for the railway station.",
)

#btw[
  The Shanghai metro is one of the largest by track distance in the world (second
  only to Beijing). However, as you move away from the city center, it starts to
  act more like commuter rail or a suburban rail link, quite similar to how the
  BART feels outside of San Francisco proper. Of course Shanghai is a lot denser,
  so each station still serves a large amount of people in the residential areas.

  This does lead to a situation where if you happen to live on the tail end of
  one of the tendrils extending outwards into the residential areas, and you
  want to get to the outer end of another line in another residential area far from
  the city center, you end up having to travel all the way to the city center
  and then back out towards your destination. (This is sort of what happened to me here.)

  A type of line called a _radial route_ is designed to alleviate these situations by running an elliptical shaped route mostly connecting existing metro lines further away from the city center to facilitate movement between them. Line 4 on the Shanghai metro is one such line, but Shanghai is quite large and Line 4 is still close to the city center.

  Moscow’s metro has some of the best designed radial routes I’ve seen.

  #webimg(
    "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Moscow_metro_map_zh-hans_sb.svg/1557px-Moscow_metro_map_zh-hans_sb.svg.png",
    "moscow metro map",
    caption: "The Moscow metro. (Image courtesy of Wikimedia Commons.)",
  )
]

Now it’s time to take a high speed train to Changsha. The previous day, I’d
booked a high-speed rail ticket for 11:56. To recap chronologically, I left at
10:25 and arrived at Hongqiao Railway Station at 11:33, 23 minutes ahead of
departure time.

#webimg(
  getResource("shanghai-hongqiao-train-station.jpg"),
  "hongqiao railway station",
  caption: "Hongqiao Station is massive. It is both a rail station and international airport.",
)

It took me around 10 minutes to get from the actual metro exit to the rail
departures entrance (all fully internally in the station), and 2 minutes to get
through the security check. They simply checked ID (and I had a foreign
passport, which needed manual inspection) and did a standard airport-style
luggage and metal detector check. Rail station checks are generally much more
lax than what you’re used to in American airports though, so no more than a
couple minutes is standard. Expect longer if you have more luggage, obviously.

#webimg(
  getResource("shanghai-hongqiao-departures.jpg"),
  "hongqiao railway station departures",
  caption: "The departures area. Lined with stores for last-minute gifts and restaurants.",
)

At this point it was 11:46, 10 minutes before boarding, so I quickly made my way over to the terminal.

#webimg(
  getResource("screenshot-12306-app-live-activity.jpg"),
  "12306 china railway live activities",
  caption: "A Live Activities widget shows me the boarding terminal and my car/seat assignment",
)

To board, I simply pulled up a boarding QR code from the _12306 China Railway_
app where I bought the ticket and scanned it at the automated fare gates. The
overall rail boarding process is not much different from boarding the metro by
using a transit QR code, besides the more stringent security checkpoint.

#webimg(
  getResource("shanghai-hongqiao-hsr-platform.jpg"),
  "platform of shanghai hongqiao high speed rail station",
)

My train was the G-class high-speed line between Shanghai Hongqiao and
Chongqing West (上海虹桥--重庆西), with a stop at Changsha South Station
(长沙南站), my destination. Chinese trains are divided into a few
letter-delineated classes which I won’t get into, but G trains are in general
the fastest high speed lines.

#webimg(
  "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/CR400AF-Z-2285_at_Qingta_Weiyuan_%2820231019132529%29.jpg/2560px-CR400AF-Z-2285_at_Qingta_Weiyuan_%2820231019132529%29.jpg",
  "fu xing cr400AF",
  caption: "The train is a Fu Xing (复兴) CR400AF, with peak speeds of 350km/h. (Image courtesy of Wikimedia Commons.)",
)

The train was sleek and modern on the inside, with comfortable seats (even in 2nd class). It departed on time at 11:56.

#webimg(
  getResource("fuxing-interior.jpg"),
  "interior of the fu xing train",
  caption: "The train interior from my seat.",
)

At this point, it was time to think about lunch. Luckily, amenities on Chinese
railways are likely the amongst the best in the world.

There are dining options available on the train, and attendants will
periodically walk around selling pre-heated TV dinner style meals.
Actually, these tasted quite good as far as TV dinners go (assuming you like
Chinese food). You can also order by scanning a QR code on your armrest and it
will be delivered to your seat.

However, there is another option. If you recall those restaurants inside the
railway station---you can actually order takeout from there to be delivered
directly to your seat. You have to order quite a bit in advance (at least 1-2
hours), but the selection is far greater than what is available on the train.
Most stations have McDonalds/KFC (which taste far better in China!) as well as
a few Chinese restaurants. You can order food from any station before your
destination, which will be picked up during the few minutes the train stops and
delivered to you shortly after.

The night before, I ordered some Taipei-style pork ribs over rice from Hangzhou
Station (杭州站) using the China Railway app. The price is on the expensive
side in terms of RMB, but was less than US\$10. Sure enough, an attendant came
by to deliver it after we left Hangzhou at around 1:00.

#webimg(
  getResource("rail-food-delivery-bag.jpg"),
  "takeout delivered to seat",
)

#webimg(
  getResource("lunch.jpg"),
  "takeout food",
  caption: "Taipei-style pork ribs over rice!",
)

After 4 hours, I arrived at Changsha South station. I made plans to meet at
Huangxing Square (黄兴广场), which had its own metro stop. I swiped my ticket
QR code to leave the rail station and walked a short distance to the Changsha
South metro station. Everything looked eerily similar to the Shanghai metro,
owing to the high degree of standardization in Chinese metro systems that
allows them to be built so prolifically.

#webimg(
  getResource("changsha-metro-platform.jpg"),
  "changsha metro",
  caption: "The Changsha metro.",
)

#webimg(
  getResource("changsha-metro-station.jpg"),
  "changsha metro transfer signs",
  caption: "Clearly marked signs to transfer trains quickly.",
)

The Changsha metro is far less developed than Shanghai’s and additional
stations and lines are still under construction. However, it is still quite
adequate. I swiped my Shanghai transit card in Apple Wallet at the fare gate,
which works nationwide due to a system called China T-Union. (e.g. I could
swipe the Beijing 一卡通 in Shanghai, the Changsha metro card in Beijing,
etc.).

A few stops and a transfer later, I arrived at Huangxing Square station. As
promised, the entire journey was done entirely via rail and without ever
leaving a metro or high-speed rail station.

#webimg(
  getResource("huangxing-square-arrived.jpg"),
  "huangxing square",
  caption: "Huangxing Square, a large shopping center in Changsha. The subway exit is located conveniently in the middle of the square (bottom middle of the image.)",
)

#webimg(
  getResource("huangxing-square-enjoying-coffee.jpg"),
  "picture of coffee with huangxing square as backdrop",
  caption: "Relaxing after the journey.",
)

The final cost, not including food,
was RMB\$530 (520元 for HSR ticket, 10元 for metro), and took 6 hours. The same
journey by car would’ve taken 11 hours and
4 minutes, as well as an aggregate toll of RMB\$501. Note that highways in China are
not free to use and collect tolls (a decision I entirely support---why subsidize drivers?). This is also
not including gas and other fees associated with owning a car.

#webimg(
  getResource("route-by-driving.jpg"),
  "apple maps route by driving",
  caption: "The same route by driving.",
)

In the end, we trekked a journey equivalent to SF to LA, entirely via public
transit, in surprising comfort, and faster than driving. The success of the
Chinese rail system is a definitive refutation of the argument that the US is
too big for rail.
