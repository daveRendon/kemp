---
layout: post
title:  "Powerful things you can do with the Markdown editor"
author: sal
categories: [ Jekyll, tutorial ]
image: assets/images/16.jpg
---

There are lots of powerful things you can do with the Markdown editor. If you've gotten pretty comfortable with writing in Markdown, then you may enjoy some more advanced tips about the types of things you can do with Markdown!

As with the last post about the editor, you'll want to be actually editing this post as you read it so that you can see all the Markdown code we're using.


## Special formatting

As well as bold and italics, you can also use some other special formatting in Markdown when the need arises, for example:

+ ~~strike through~~
+ ==highlight==
+ \*escaped characters\*


## Writing code blocks

There are two types of code elements which can be inserted in Markdown, the first is inline, and the other is block. Inline code is formatted by wrapping any word or words in back-ticks, `like this`. Larger snippets of code can be displayed across multiple lines using triple back ticks:

```
.my-link {
    text-decoration: underline;
}
```

#### HTML

<p>
<table class="table-narrow">
	<thead>
		<tr>
			<th>Features</th>
			<th>Azure Load Balancer</th>
			<th>Azure Application Gateway</th>
			<th>LoadMaster for Azure</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Basic and Standard Tier VM support</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Network Level L4 load balancing</td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Multiple application access with single IP</td>
			<td>Limited</td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Pre-configured application templates</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Web User Interface for ease of management</td>
			<td>Limited</td>
			<td>Limited</td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>High Availability &amp; Clustering</td>
			<td>Limited</td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Web Application Firewall</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td>Limited</td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Hybrid Traffic Distribution</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Scheduling methods</td>
			<td>Round Robin Only</td>
			<td>Round Robin</td>
			<td>Multiple</td>
		</tr>
		<tr>
			<td>Server Persistance</td>
			<td>IP Address</td>
			<td>IP Address Cookies</td>
			<td>Multiple</td>
		</tr>
		<tr>
			<td>SSL Termination/Offload</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Content Caching/Compression</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Least Connection Scheduling</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Server Name Indicator (SNI)</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>VM Availability Awareness</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Two Factor Authentication</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Health Check Aggregation</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Single Sign On</td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>SmartCard(CAC) / X.509 Certificate Authentication</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>LDAP Authentication</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Radius Authentication</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Kerberos Constrained Delegation</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>AD group based traffic steering</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Header content switching</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td>Limited</td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Header manipulation</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Content Rewriting</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Adaptive scheduling</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>OCSP Certificate Validation</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>SAML Authentication</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>HTTP/2 Support</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Reverse Proxy</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
	</tbody>
</table>
</p>

#### CSS

```css
.highlight .c {
    color: #999988;
    font-style: italic; 
}
.highlight .err {
    color: #a61717;
    background-color: #e3d2d2; 
}
```

#### JS

```js
// alertbar later
$(document).scroll(function () {
    var y = $(this).scrollTop();
    if (y > 280) {
        $('.alertbar').fadeIn();
    } else {
        $('.alertbar').fadeOut();
    }
});
```

#### Python

```python
print("Hello World")
```

#### Ruby

```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```

#### C

```c
printf("Hello World");
```




![walking]({{ site.baseurl }}/assets/images/8.jpg)

## Reference lists

The quick brown jumped over the lazy.

Another way to insert links in markdown is using reference lists. You might want to use this style of linking to cite reference material in a Wikipedia-style. All of the links are listed at the end of the document, so you can maintain full separation between content and its source or reference.

## Full HTML

Perhaps the best part of Markdown is that you're never limited to just Markdown. You can write HTML directly in the Markdown editor and it will just work as HTML usually does. No limits! Here's a standard YouTube embed code as an example:

<p><iframe style="width:100%;" height="315" src="https://www.youtube.com/embed/Cniqsc9QfDo?rel=0&amp;showinfo=0" frameborder="0" allowfullscreen></iframe></p>
