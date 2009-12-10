OAUTH_CREDENTIALS={
   :twitter=>{
     :key=>"key",
     :secret=>"secret"
   },
   :agree2=>{
     :key=>"key",
     :secret=>"secret"
   },
   :hour_feed=>{
     :key=>"",
     :secret=>"",
     :options={
       :site=>"http://hourfeed.com"
     }
   },
   :nu_bux=>{
     :key=>"",
     :secret=>"",
     :super_class=>"OpenTransactToken",  # if a OAuth service follows a particular standard
                                         # with a token implementation you can set the superclass
                                         # to use
     :options=>{
       :site=>"http://nubux.heroku.com"
     }
   }
 }
