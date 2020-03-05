# Quick Installation Guide
--------------------------------------------------------------------------------

In order to use the dispatcher, execute the following steps

1. Install Apache.
2. Install the dispatcher module 
3. Configure httpd.conf (the Apache configuration)
4. Configure dispatcher.any (the dispatcher configuration)
5. Start Apache
6. Tips

--------------------------------------------------------------------------------
### Install Apache

  On Linux, use the distribution's package manager (e.g. apt-get or yum) to
  install Apache. For other *nixes (e.g. Solaris or AIX), Apache might come
  preinstalled; if not, check their documentation on how to install Apache.

  On Mac OS X, due to the latest security precautions introduced, preinstalled
  Apache will no longer load unsigned modules or modules not signed by Apple.
  The dispatcher binary for Mac OS is therefore built against the version
  provided by [brew](https://brew.sh/). In order to install brew's Apache
  on your Mac OS X, run:
  ```
  $ brew install httpd
  ```

  If you want to install Apache from source, consult the INSTALL manual in
  the source distribution package. It is important, that you turn on dynamic
  modules support. This can be done by use any of the --enable-shared
  option, or at least include the mod_so module with the --enable-module=so
  option. Read the INSTALL manual for further detail.

--------------------------------------------------------------------------------
### Install the dispatcher module

  The dispatcher module comes in a binary distribution package for every
  supported platform. The module has the following naming convention:

  `dispatcher_apache2.4_x.y.z.so`

  where x.y.z is the version number.

  Copy the dispatcher module to the directory where your other Apache
  modules reside: usually, this is the `modules` subfolder of your server root,
  the exact location can be found by looking at the existing `LoadModule`
  directives in your `httpd.conf` configuration file.

  For easier handling, create a symbolic link named `mod_dispatcher.so` to
  the dispatcher module:
   
  ```
  $ ln -s dispatcher_apache2.4_x.y.z.so mod_dispatcher.so
  ```
  This will allow you to install different versions of the dispatcher in your
  modules directory, enabling you to switch between those versions by altering
  the target of the symbolic link.

--------------------------------------------------------------------------------
### Configure httpd.conf

  a) Load the dispatcher module, by adding a line to httpd.conf, ideally at
  the end of the section containing all `LoadModule` instructions:
  ```
  LoadModule dispatcher_module modules/mod_dispatcher.so
  ```
  In case of CentOS/RHEL, create a file 01-dispatcher.conf under conf.modules.d and update it with 
  ```
  LoadModule dispatcher_module modules/mod_dispatcher.so
  ```
   
  b) Set the dispatcher as primary handler for all documents in your document root:
  
  - Determine your document root by finding the Apache directive *DocumentRoot*, e.g.:
    ```
    DocumentRoot "/usr/local/var/www"
    ```
  - Locate the *Directory* section configuring that document root, e.g.:
    ```
    <Directory "/usr/local/var/www">
      ...
    </Directory>
    ```
  - Now, add a conditional sub section to that section that will invoke the dispatcher:
    ```
    <Directory "/usr/local/var/www">
      ...
      <IfModule disp_apache2.c>
         ModMimeUsePathInfo On
         SetHandler dispatcher-handler
      </IfModule>
    </Directory>
    ```
  
  c) Copy the packaged `conf/httpd-dispatcher.conf` to Apache's `extra` folder,
     where extra module configurations are kept, and include it at the very
     bottom of httpd.conf:
  ```
  Include extra/httpd-dispatcher.conf
  ```
  Note : If configuring Apache on CentOS/RHEL, in the absence of extra folder, copy this conf to 'conf.d' folder. Please confirm that your httpd.conf file already contain following lines :
  ```
  Include conf.modules.d/*.conf
  ```
  before Documentroot configuration
  and,
  ```
  IncludeOptional conf.d/*.conf [This
  ```
  at the end of httpd.conf file

--------------------------------------------------------------------------------
### Configure dispatcher.any (the dispatcher configuration)

  Place the packaged `dispatcher.any` alongside httpd.conf. Then, open it in
  an editor and change the following:

  - The `/renders` section is preconfigured to dispatch requests to AEM running
    on localhost, listening on port 4503. If this is not the address of your
    AEM instance, change it accordingly
  - The `/cache` section contains an entry for the cache `docroot`. This should
    match the value of the `DocumentRoot` directive you located in the previous
    step.
   

--------------------------------------------------------------------------------
### Start Apache

  Depending on your OS, you either start Apache directly with `httpd` or 
  `apachectl` or by starting the `httpd` service:
  ```
  $ sudo service httpd start
  ```
  If Apache doesn't start up, consult Apache's error log and/or the dispatcher
  log file. You can also tail them before starting Apache:
  ```
  $ tail -F logs/error_log &
  $ tail -F logs/dispatcher.log &
  ```

--------------------------------------------------------------------------------
### Tips

   - On first installation set the `DispatcherLogLevel` to `Debug`
   - Surf your AEM site through Apache and verify it looks as expected
   - Take a look at the document root and verify it gets filled
   - Activate a page from AEM, and verify that the cache gets flushed correctly
   - If everything looks fine, you can reduce the log level to `Warn`
