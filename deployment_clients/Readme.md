## Managing from middle to huge Splunk environment :sunglasses:

Well, when I started work with Splunk and needed to managing the universal forwarders deployed around the infrastructure I've like to have a unified place to do this and... voilà, we have the Forwarder Management.

One of the most great thing here is that you can manager all yours UF clients by one place and I use one tips to make this more... easily :sunglasses: .

When I'm deploying a new Universal Forwarder, I always put together an app that points to my Deployment Server :D. This little tricks able you to save some time. So, If you want to use this, just get it at here. Enjoy!

This space is divided in: 

1.	Deployment Universal Forwarder:
	- [ ] Create an app called deployment_client_target;
	- [ ] Code the files;
	- [ ] Parametrize the files (Linux & Windows);
	- [ ] Prepare to deploying the app (Linux & Windows);
	- [ ] Make your own test (Linux & Windows);