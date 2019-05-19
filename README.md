# Web-Serve-This-Directory

This repository contains a Bash script that starts a Python web server with the current directory at its root.

In case `qrencode` can be detected, a QR code with the URL of the web server is also created. When scanning the QR code on a phone or tablet connected to the same network, it allows instant access to the local machine. This can save a lot of typing.

> **Warning**:  This web server is great for quick and dirty experimentation in a development environment. DO NOT use this web server in a production environment! It is unsuitable for the task, does not scale well, and there are better options available. Instead choose one of the battle tested web server such as [nginx](http://nginx.org/).

See also [link-to-come]() for a more detailed explanation on why the world is better off with a 100 line Bash script that's essentially wrapping a one line command; for Python2 that is
```
python -m SimpleHTTPServer
```
and for Python3
```
python3 -m http.server
```


## You Have

Before you can use the Bash script in this repository out of the box, you need

 - a [Python](https://www.python.org/) installation, either Python2 or Python3
 - an available port for the web server to listen on

Optionally, install [`qrencode`](https://fukuchi.org/works/qrencode/index.html.en) if you want to automatically generate a QR codes for the web server URL each time it starts.


## You Want

After running the Bash script in this repository you can access the contents of the current directory from any device in the same network over HTTP.


## Execution

The stand-alone Bash script `web-serve-this-directory.sh` is located in the root folder of the repository.

### Starting the Web Server

The current directory can be served over HTTP on port `8000` via
```
./web-serve-this-directory.sh -p 8000
```

In case the local IP address is `192.168.1.162`, this will start the web server and produce the following output
```
$ ./web-serve-this-directory.sh -p 8000
Visit http://192.168.1.162:8000 from your mobile to download files in this directory.
Scan http://192.168.1.162:8000/webserver_url.jpg with your mobile for quicker access
Press Ctrl-C to stop the web sever
Serving HTTP on 0.0.0.0 port 8000 ...
```

Note that since `qr_encode` could be detected, a QR has been generated and can be accessed on http://192.168.1.162:8000/webserver_url.jpg.


### Stopping the Web Server

The web server can be stopped by pressing `Ctrl-C`; this is actually standard Python web server behaviour. The full output for the above example is
```
$ ./web-serve-this-directory.sh -p 8000
Visit http://192.168.1.162:8000 from your mobile to download files in this directory.
Scan http://192.168.1.162:8000/webserver_url.jpg with your mobile for quicker access
Press Ctrl-C to stop the web sever
Serving HTTP on 0.0.0.0 port 8000 ...
^CTraceback (most recent call last):
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/runpy.py", line 162, in _run_module_as_main
    "__main__", fname, loader, pkg_name)
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/runpy.py", line 72, in _run_code
    exec code in run_globals
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/SimpleHTTPServer.py", line 235, in <module>
    test()
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/SimpleHTTPServer.py", line 231, in test
    BaseHTTPServer.test(HandlerClass, ServerClass)
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/BaseHTTPServer.py", line 599, in test
    httpd.serve_forever()
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/SocketServer.py", line 236, in serve_forever
    poll_interval)
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/SocketServer.py", line 155, in _eintr_retry
    return func(*args)
KeyboardInterrupt
$ 
```

Note that the `KeyboardInterrupt` error is expected. `Ctrl-C` was pressed after all - which qualifies as a `KeyboardInterrupt`.


## FAQs

Below is a list of frequently asked questions.

### Why is there no HTTPS Support?

The server is intended to be a simple lightweight way to serve files from a local network. It should not be used to transfer sensitive files. However, it seems to be possible to add HTTPS support. Feel free to improve as outlined below, so we can make things better for everyone.

### I Know How to Make This Better!

Excellent. Feel free to fork this repository, make the changes in your fork, and open a pull request so we can make things better for everyone. Thanks!
