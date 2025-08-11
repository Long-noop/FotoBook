
# Fotobook (Advanced)
## Introduction

![
](https://live.staticflickr.com/65535/50018030173_f454239f46_b.jpg "Discover")

Fotobook (Photobook) is a free photo sharing website designed to be a place for people around the world to express themselves through photos. It's there for those who love photography and also want to share their precious moments in life.

Fotobook's features will be pretty similar to [Facebook](https://www.facebook.com/)'s ones but much simpler. Check out its prototype [here](https://www.figma.com/file/nnL5Eqk7N19uFY2bc6qQWU/Fotobook-Final-App-Advanced) to have a closer look.

### Main entities in Fotobook
#### User
There are 03 types of user existing in the application system:

* Guest: users visiting the application without logging in.
* Normal user: users who have normal account.
* Admin user:  users who have administrator account and, therefore, have been granted several advanced permissions to manage the application.

Each type of user has its own permissions. The following sections will cover them in more detail.

#### Photo
Photo is one of the fundamental entities in the application. Basically, it's a combination of three components:

* A image that user want to share.
* Photo title.
* Photo description.

In addition, each Photo can be shared in either `public` or `private` mode.

#### Album
Rather than posting a series of Photos separately, user can choose to group those images under an Album. Three components forming up an Album are:

* A collection of images that user wants to group as an album.
* Album title.
* Alum description.

Just like Photo, Album can also be shared in either `public` or `private` mode.

## General requirements

* It's  unnecessary to build a UI looks like the [sketch](https://www.figma.com/file/LGNsg3hOszz33F93ArIZZtOe/Fotobook-Final-App) precisely.  However, the clarity and ease of use are must-have. Plus, all described functionalities have to be presented in the interface as well.
FYI, all icons used in the [sketch](https://www.figma.com/file/LGNsg3hOszz33F93ArIZZtOe/Fotobook-Final-App) are from [Font Awesome](https://fontawesome.com/cheatsheet).

* Responsive layout is set up for at least 2 screens (mobile and desktop) based on Bootstrap [Grid system](http://getbootstrap.com/docs/3.3/css/#grid).

* Strictly follow the [best practices](#best-practices) have been told in all cases. Consult your trainer / supervisor if you want to make your own choice.

* Write `Unit test` at least for Model.
## Application features
Features / screens of Fotobook will be described in the below sections. Each section covers:

* In detail description of feature / screen.
* Technical notes (if any).
* Advanced requirements (if any).

*Advanced requirements might be optional in certain circumstances. You should ask your trainer / supervisor for a confirmation.*

### Signup
![
](https://live.staticflickr.com/65535/50018826102_a26fb345c9_b.jpg "Sign up")
This page allows user to create new Fotobook account. Its provides two sign up methods:

* By social network accounts. The application support the three most popular providers including: [Google](https://www.google.com), [Facebook](https://www.facebook.com), and [Twitter](https://www.twitter.com).

* Typically sign up by providing necessary information:

	* First name (required): maximum 25 characters long.
	* Last name (required): maximum 25 characters long.
	* Email (required): maximum 255 characters long. Besides, it has to be unique and comply with the general email format.
	* Password (required): maximum 64 characters long.

It is highly recommended to have `First Name` field auto-focused right after the page has successfully loaded.

**Technical notes:**

* Use [Devise](https://github.com/plataformatec/devise) gem to implement signup including `:confirmable`.
* Use [Bootstrap](http://getbootstrap.com/docs/3.3) to build UI. A good example can be found [here](https://bootsnipp.com/snippets/featured/google-style-login).

### Login
![
](https://live.staticflickr.com/65535/50018570591_ca28d5999c_b.jpg "Login")
This page is the entry point of Fotobook where user can log into the application. The credentials user has to provide including:

* Email (required).
* Password (required).

`Email` field is auto-focused by default. After successfully logging in, user will be directed to their [Feeds](#feeds).
Users can also reset their passwords if they want to.
Correspondingly to the [Singup](#signup) page,  logging in by using social network accounts is supported as well.
*Note that user will no longer has the ability to log into the application after being set inactive by admin.*


**Technical notes:**

* Use [Devise](https://github.com/plataformatec/devise) gem to implement signin and reset password.
* Use [Bootstrap](http://getbootstrap.com/docs/3.3) to build UI. A good example can be found [here](https://bootsnipp.com/snippets/featured/google-style-login).

### Feeds
![
](https://live.staticflickr.com/65535/50018832227_fe066e47e6_b.jpg "Feed Photos")
Feeds is the main page of the application. It's the place to display public posts of the users who you are currently following. A post can be either Photo or Album. User can freely switch between two modes: `Photo` or `Album` (reload page). Be alert that only Photo / Album whose sharing mode is set `public` will be shown up there. No mater how you style the page, each post has to satisfy the following constraints:

* Displaying clearly:

	* Photo / Album thumbnail.
	* Author information (name, avatar).
	* Photo / Album title.
	* Photo / Album description.
	* Photo / Album publication date.

* Posts are designed to display in reverse chronological order (from newest to oldest).

#### Post interactions

There are several actions that user can interact with each post:

* Clicking on the heart icon at the bottom to like the post
* Clicking on the thumbnail to open post's content
* Clicking on author name / avatar to go to his [Public Profile](#public-profile)

#### View post content
User can view post's content by clicking on each item. If it is a Photo, a popup modal will show up displaying the image inside together with its `title` and `description`.

![
](https://live.staticflickr.com/65535/50018572881_08e6d21a8e_b.jpg "Photo View")

In case the post is an Album, a popup modal will show up displaying the images collection inside that Album together with the its `title` and `description`. User can clicking on the left / right arrow to navigate around.

![
](https://live.staticflickr.com/65535/50018044563_11dbc91ffe_b.jpg "Album View")

Non-login users can freely access Feeds and perform all kind of [interactions](#post-interactions) mentioned above except that they cannot like the post.

**Technical notes:**

* Infinite loading post (scrolling down to load more items)
* Use [Bootstrap modal](http://getbootstrap.com/docs/3.3/javascript/#modals).

### Disovery
![
](https://live.staticflickr.com/65535/50018045023_1abfa3aed6_b.jpg "Discover Photos")
This page is pretty much the same as [Feeds](#feeds) in term of layout. The business logic is slightly different though. Specifically, not restricting posts from following users only, this page displays public posts from all users in the application.

Besides basic [interactions](#post-interactions) stated above, user can `follow` / `unfollow` from this page. There should be some kinds of marks / labels indicating the follow status on each post item.

### Public Profile

This page can be accessed and viewed publicly by any users in the application. It is a combination of several tabs showing information of the visited user such as:

* The number of public photos
* The number of public albums
* The number of followings
* The number of followers

We can also decide to `follow` / `unfollow` the user here at this page.

#### Tab Photos

All public Photos of the visited user will be displayed here.

![
](https://live.staticflickr.com/65535/50018833837_85c11b5033_b.jpg "Tab Photos")

#### Tab Albums

All public Albums of the visited user will be displayed here.

![enter image description here](https://live.staticflickr.com/65535/50018574196_3b191e7090_b.jpg "Public Profile - Albums")

#### Tab Followings
All followings (the users that the visited user currently follows) of the visited user will be displayed here. We can even start following those users easily here.

![
](https://live.staticflickr.com/65535/50018834337_01c8572d8d_b.jpg "Public Profile - Followings")

#### Tab Followers

All followers (the users that currently follows the visited users)  of the visited user will be displayed here. We can even start following those users easily here.

![
](https://live.staticflickr.com/65535/50018575206_f817704511_b.jpg "Public Profile - Followers")

### My Profile
This page is a personalized version of [Public Profile](#public-profile) with additional features enabled. After logging in, user can click on avatar / user name in the top navigation bar in order to access the page.
User can click `Edit Profile` button to go to [Edit profile](#edit-profile) page.

#### Tab Photos

![
](https://live.staticflickr.com/65535/50018835387_8e3430a4be_b.jpg "Tab Photos")

Here user can click on each thumbnail to view the Photo, click on `Edit` button to go to [Edit Photo](#edit-photo) page. There should be a sign on each thumbnail to indicate whether the photo is public or private (with lock icon).

User can click `Add Photo` button to add more photos in [New Photo](#new-photo) page.
#### Tab Albums

![
](https://live.staticflickr.com/65535/50018575996_3114f2993f_b.jpg "Tab Albums")

Here user can click on each albumn thumbnail to view the photo collection, click on `Edit` to go to [Edit Album](#edit-album) page. There should be a sign on each thumbnail to indicate whether the album is public or private (with lock icon). The number of photo inside each album could be placed somewhere on the thumbnail also.

User can click `Add Abum` button to add more album in [New Album](#new-album) page.

#### Tab Followings

All followings of the current loged-in user will be displayed here. The user can decide to stop following any of those by clicking on the `unfollow` button.

![
](https://live.staticflickr.com/65535/50018576371_62e7fae1c4_b.jpg "Tab Followings")

#### Tab followers

All followers of the current logged-in user will be displayed here. The user can even start following back to any of followers in the list.

![
](https://live.staticflickr.com/65535/50018047908_350478a132_b.jpg "Tab Followers")

### New Photo

![
](https://live.staticflickr.com/65535/50018836902_d830b4bbfa_b.jpg "New Photo")

It's the place where user can add new Photo to their collection. New Photo form has the following fields:

* Title (required): maximum 140 characters long.
* Description (required): maximum 300 characters long.
* Sharing mode (required): `public` or `private`.
* Attached image (required): maximum 01 image. Accepted formats are `jpeq`, `png` and `gif`. Maximum size is 5Mb.

After successfully creating a new Photo, user will be directed to [My Photos](#my-photos) on reload. There has to be appropriate notification messages letting user know whether the operation is successful or failed.

**Technical notes:**

* Form fields must have placeholders.
* Use [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) gem for image attachment.

### Edit Photo

![
](https://live.staticflickr.com/65535/50018048563_8552d81636_b.jpg "Edit Photo")

This page shares the same components / features with [New Photo](#new-photo) except that it has an extra button letting user delete the Photo.

**Technical notes:**

* There has to be an alert box for double confirmation whenever user clicks on `Delete` button.

### New Album

![enter image description here](https://live.staticflickr.com/65535/50018837467_e5fedeae25_b.jpg "New Album")

It's the place where user can add new Album to their collection. New Album form has the following fields:

* Title (required): maximum 140 characters long.
* Description (required): maximum 300 characters long.
* Sharing mode (required): `public` or `private`.
* Attached images (required): maximum 25 images. Accepted formats are `jpeq`, `png`, `gif`. Maximum size for each image is 5Mb.

User can add only one image to an Album each time. After hitting `Save` button, the page will be reloaded to let user add more images if he wants to. There has to be appropriate notification messages letting user know wether the operation is successful or failed.

**Technical notes:**

* Form fields must have placeholders.
* Use [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) gem for image attachment.

**Advanced requirements:**

* Enable multiple images uploading.
* Allow user to create a new Album out of existing Photos.

### Edit Album

![
](https://live.staticflickr.com/65535/50018837757_32f7cf0e44_b.jpg "Edit Album")

This page shares the same components / features with [New Album](#new-album) except that it has an extra button letting user delete the Album.
All belonging images will be removed if their parent Album is deleted.

**Technical notes:**

* There has to be an alert box for double confirmation whenever user clicks on `Delete` button.

### Edit Profile

![
](https://live.staticflickr.com/65535/50018049498_6bfef3cc0a_b.jpg "Edit Profile")

User can edit personal information in `Edit Profile` page. There's currently only one entry to access this page - hitting `Edit Profile` button in [My Profile](#my-profile) page. Editable information including:

* Avatar (optional): Accepted format: `jpeg`, `png`. Maximum size is 2Mb.
* First Name (required): described in [Signup](#sign-up).
* Last Name (required): described in [Signup](#sign-up).
* Email (required): described in [Signup](#sign-up).
* Password (required): described in [Signup](#sign-up).

**Technical notes:**

* There has to be appropriate notification messages letting user know whether the operation is successful or failed.

## Admin dedicated features
### Manage Photos
![
](https://live.staticflickr.com/65535/50018049928_48668d3b03_b.jpg "Manage Photos")
Admin has the right to manage all existing Photos in the application even when their sharing modes are currently set to `private`.

**Technical notes:**

* Paginate 40 items per page.
* Reuse [Edit Photo](#edit-photo) page.
### Manage Albums
![
](https://live.staticflickr.com/65535/50018050278_d54dbb82eb_b.jpg "Manage Albums")

Admin has the right to manage all existing Albums in the application even when their sharing modes are currently set to `private`.

**Technical notes:**

* Paginate 40 items per page.
* Reuse [Edit Album](#edit-album) page.

### Manage Users
![
](https://live.staticflickr.com/65535/50018579246_bd55f4750a_b.jpg "Manage Users")
Admin has the right to manage all existing users in the application. Available actions are:

* Permanently delete a user.
* Update personal information of a user.
* Temporarily set a user to be inactive / active.

![
](https://live.staticflickr.com/65535/50018050888_e12d71b008_b.jpg "Admin edit user")

**Advanced requirements:**

* Send notification email after a user is deleted / set inactive. The user can no longer log into the application afterward.

### Navigation
The navigation bar might look different depending on current logged-in user. Specifically, its elements are:

* For Guests: Fotobook logo and login link.
* For logged-in users: Fotobook logo, avatar, username and logout link.
* For Admins: Fotobook Admin, avatar, username and logout link.

Users will be directed to [Edit Profile](#edit-profile) page if they click on avatar or username.

**Technical notes:**

* For users who haven't had an avatar yet, we use initial characters of their first and last name to create a default one for them.

**Advanced requirements:**

* Implement search box for Photo and Album. The results will be separated into two groups and displayed as in [Feeds](#feeds).
* Notifications when someone likes your Photo / Album.

## Best Practices
> 1/ Inline javascript is prohibited. Use Javascript Object pattern for managing Javascript code.
>
> 2/ Don’t hard-code text and path / url. Must use I18n and UrlHepler (JS-Route at client side).
>
> 3/ Don’t rescue Exception.
>
> 4/ Shouldn’t have N+1 query issue.
>
> 5/ Don’t use instance variables (`@`) in partial view.
>
> 6/ Don’t use inline style, internal css.
>
> 7/ Only use `respond_to do |format|` (in controller) when we really need. Don’t use it in the wrong way.
>
> 8/ Do not declare method option for `link_to` if the method is `get`.
>
> 9/ When using `cancancan`: load / authorize resource automatically, don't do that manually.
>
> 10/ The description of Unit Test example should be clear and meaningful. Don’t write general descriptions like: “should work”, “should not work”.
>
> 11/ Never update a migration which has been pushed.
>
> 12/ When using I18n-js: only put the translations which we need to use in JS to the JS translation file.
>
> 13/ Do not declare method option for `form_tag` if the method is `post`.
>
> 14/ The view should not contain any logics. Place them in helpers instead.
>
> 15/ Do not commit the files which haven't been used by application on staging / production, or make any configurations without approval.
>
> 16/ Follow RESTful for resources.
>
> 17/ Use `I18n` as much as possible.
>
> 18/ Do not use string concatenation in `CoffeeScript`, use interpolation instead.
>
> 19/ Need to follow naming convention.
>
> 20/ In javascript do not compare `.length > 0`,  `a == true|false`, `a == ''`
# FotoBook DEMO

* User Authentication: https://www.loom.com/share/d5d63f74144d417b9acce1e7a2a2a072?sid=298a62c6-e3ba-480d-b7ee-d6073682d5d9
* Create/Show/Edit/Update/Delete Photo: https://www.loom.com/share/b6a378a89fdd4e7dbd0addb22a4da7d8?sid=b5a327e3-0248-4793-83d8-0f41787457f8
* Create/Show/Edit/Update/Delete Album: https://www.loom.com/share/abf4169ee2f24cceb7fd3007b5c416a1?sid=1b77e54b-a6ad-40b8-8a3a-cc255b935146
* Show/Edit/Update/ User Profile: https://www.loom.com/share/d1ad8bc5eece49119e196e42d8d5bc85?sid=9a555099-3f70-4e3d-a830-717ecb6a0132
* Like/UnLike Photo/Album & Follow/UnFollow User: https://www.loom.com/share/9c4407bbf28b4f71b5b0ff3fbe79a5d8?sid=c2203f25-a940-45f5-810b-47802ae6b589
* Admin view: https://www.loom.com/share/e2ff6dd4da1a439c8320e8581ff78a8d?sid=bd541251-2946-4a01-990d-67557238f249    
