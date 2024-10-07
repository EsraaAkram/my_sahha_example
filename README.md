# my_sahha_example


=Steps I did:
1. Created account on [sahha]( https://app.sahha.ai/auth/register/) and get appId and appSecret for sandbox
2. I followed the [Quickstart Guide](https://docs.sahha.ai/docs/quickstart/) and 
sahha package, it was straightforward example
 https://pub.dev/packages/sahha_flutter you can see their example here on the lib/Views
3. I edited their example a little bite to have the normal app walkthrough


so In auth screen, user enter his externalId then after successful authentication
App ask user for the permissions ( sleep, step_count, heart_rate)

I will check if we has user profile data in sharedpreference so if not I convert him to profile screen to input them
(I did this step so if a user signed in then press back next time I will convert him to profile screen to input his data and I will know that he did his step by checking sharedpreference )
 
user will be redirected to the profile screen to share his age and gender then redirected to the Main screen
5. In the Main Screen:
I added a menu for (edit profile and logout)
also I used the same Home screen in sahha example
It has Sensor permissions and a button to open SensorPermissionView 
6. In SensorPermissionView:
this screen has one state to check the permission state and 5 buttons
"Get some" get the same permissions above
"Get empty","Enable empty":testing only
"Open App Settings": convert user to app settings, if he want to add or remove sensors permissions manually
"enable some": enable sensors to start tracking
7. last screen is the insight screen which just a webview that provides insights from user data depending on the sensors the app follow
8. Next time, user open the app he will be redirect to the Main screen, after checking the auth data, like described above



-To be honest I didn't find a lot to do in this project, the documentation and the example was doing everything 
-So I kept almost everything the same but I tweaked it a bit according to the case I described above
"sahha" example still in Views folder and mine at screens
-common view is in common (SensorPermissionView is created by sahha and I used it )