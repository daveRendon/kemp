# BLock URLs KEMP LoadMaster using ESP and WAF

## Customer requirement: 

End User(EU) has a requirement to limit access for specific user groups, for instance, when a specific user wants to navigate to YouTube (silly example) -> then block the access to the entire URL and review logs.

You will need to enable ESP and have the users authenticate against the LM. 

## Solution 1.
You can assign a content switching rule to achieve this task:

```
Rule: Admin URLMatch
Rule Type: Content Matching
Match Type: Regular Expression
Match String: URL/folder/.*
```
However the content switching rule above would not generate logs when it was used to allow/block traffic, so you may see a shortcoming there too. 

Luckily enough, ESP can also limit directory access which will also provide security logs when someone requests something they shouldn’t. I would certainly look into ESP and Session Steering to achieve the desired results. 

On a side note, since the example was youtube, I wanted to ensure the EU didn’t want the LoadMaster to act as a forward proxy, instead of reverse proxy… just something to keep in mind.

## Solution 2. Using ESP Module 

ESP is going to allow you whitelist URLs, so if you have a URL you want to block, you basically have to tell the LoadMaster about every other URL that you want your users be able to visit. 

The other thing you can try is maybe doing a WAF Rule.

You can allow just certain user to access based on their users group that they provided. You would use steering session capabilities, you differentiate and send clients to either "Sub VS 1" which is the special users that can access to the URL and then the "Sub VS 2" which is everyone else. 

Content Rules says that if you request the specific URL, go to the Sub VS and you are going to be able to access if you are eligible to access to the Sub VS. 

In the ESP logs you will see the requests that are being blocked:

## Demo: 

[![Block URL LoadMaster](http://img.youtube.com/vi/pv5RfhaMXsg/0.jpg)](http://www.youtube.com/watch?v=pv5RfhaMXsg)





