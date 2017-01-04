# SEEK_R

### Requirements:

- iPhone

### Built with:

- XCODE 8
- Swift 3
- Ruby on Rails
- Postgres DB

### Installing:

To download this app, you must have Xcode installed on your computer. Clone the repository, and run the application in xcode on a device connected to your computer. User registration will be required in order to begin. At the time, this app is only supported on iOS devices.

### What is SEEK_R?

SEEK_R is an iOS application where users can send encrypted messages to one another along with their coordinates. Messages are encrypted prior to being sent, and are stored encrypted as well. The only way to decrypt a message, is for the intended user to use their private key, which is created and stored only on their personal device.  

When a user sends their current GPS location in a message, the other user can display that location in their native apple maps location by clicking the button inside of their private message with that user. 

### Backend

SEEK_R is backed by a Ruby/Rails server that utilizes postgres to store user information, along with messages between users. Here is the repo: https://github.com/travispbuckley/seek_r-backend

### Authors

* Eraince Wang @eraince
* Matthew Ramuta @mramuta
* Kenneth Kang @kangkg
* Travis Buckley @travispbuckley

### Acknowledgements

Shoutout to all DBC staff and mentors for their continued support and knowledge. And to our fellow students who gave us an awesome environment to work in.
