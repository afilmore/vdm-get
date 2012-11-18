vdm-get

Compile the source :

    - You need autoconf, automake, vala compiler and other stuff I forgot.
    
    - install libraries :

        sudo apt-get install libglib2.0-dev libxml2-dev
        
    - build the code :
    
        ./autogen.sh && ./configure --prefix=/usr && make
        
    - run the app :
    
        ./src/vdm-get
