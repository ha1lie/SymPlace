# SymPlace
_** A safe space discovery app for everyone!**_

**View the promo video [here](https://youtu.be/wKpznGX4PWU)!**

## Inspiration
Every day, minorities across the globe face the problem of aggressions, both micro and macro, for just being who they are. I myself am a trans woman, and I often find myself wishing I knew of places in my area that would be accepting of me, and that I would feel comfortable in. I know that everyone from people of color to queer couples feel the same as well. 

So I did what a developer does best, **open-sourced the world**! _Imagine_ that all of the sudden you had access to information about everyone's favorite restaurants to eat, coffee shops where they felt accepted, and could even be warned away from those that aren't so kind ~

## What it does

So, I built SymPlace!

SymPlace acts as a geocacher in the background of your phone, securely storing the places you visit on device, and when it notices you visiting a location often, it'll ask you to review it based on a few factors:
 - **LGBTQ+ Acceptance**: _How accepting is this establishment of queer individuals? Do you feel safe?_
 - **BIPOC Acceptance**: _How accepting is this establishment of people of color? Do you feel safe?_
 - **Staff Allyship**: _Do the staff of this establishment treat you well? Do you feel judged?_
 - **Visibility**: _Did you have a good experience, or just not a bad one? Did the environment communicate that it was a safe space?_

With this information, it congregates an average score, and can present it to the user in a quick summary. Users can rate places already reviewed by others to get a better idea of the broad picture. You can also check the app to find already-rated establishments around you!

## How I built it

SymPlace was built with many technologies: 
 - **Xcode and Swift 5.5**: _An iOS development IDE, and Apple's latest and most advanced framework for developing native apps_
 - **Node.js**: _I am utilizing a node server hosted on a linux computer to host the backend of my app, and store data while the app is still being finalized and produced_
        - **Packages**: _[node-apn](https://github.com/node-apn/node-apn), [fs-extra](https://www.npmjs.com/package/fs-extra), and [body-parser](https://www.npmjs.com/package/body-parser) were the main packages utilized for the backend_
 - **[Geocode.xyz](https://geocode.xyz)** was used to geocode the user's location, while maintaining anonymity from the backend server

While the journey of building this app was a roller coaster for sure, one that did in fact bring many successes also brought many...

## Challenges I ran into

_Time issues!_ Working alone I had to truly prioritize what I was going to work on, and what time I would allot myself per task. Jumping between languages to be able to develop the server and app at the same time proved to be difficult, but **not impossible**!

Another difficult thing was testing visit-services provided to me by CoreLocation on device. Being in the cold upstate New York air made moving around campus often difficult, and also added another difficulty to testing this app, having to significantly change locations while debugging!

Despite all of the challenges, there were lots of...

## Accomplishments that I'm proud of

 - This was my first time using push notifications as well, and having enabled them for devices was a great success! Especially being able to write a backend that will allow me to filter for notifications as needed in the future allows this app to grow very quickly! 

 - Successfully writing an entire backend in Javascript to handle a custom app, using minimal frameworks! I kept it to the bare minimum, only pulling in [node-apn](https://github.com/node-apn/node-apn) once I felt the time constraints were ticking down on me.

 - I was able to build a fully functioning app within 24 hours! Despite not being able to implement every feature that I would like to before launching this to the public, I was able to start with an empty Xcode project, and complete a product! 

These accomplishments lead the way for all of the...

## Things I learned

 - Push notifications
 - Backend development 
 - Swift URL Request _proficiency_(Despite having previous experience)
 - Running to the other side of campus is a good brain break and wake up activity
 - So much more!

## What's next for SymPlace

SymPlace is currently open source on Github [here](INSERTLINK). I'm going to continue to perfect SymPlace by implementing features that I didn't quite get a chance to today, such as location searching, as well as expand SymPlace to Android devices to allow even more people to find their happy places!

Based on my progress in the fast 24 hours, my goal is to **launch SymPlace by the end of the year in beta** mode, and _**begin caching the worlds first safe-place database**_ for the world to access!
