package :apache_upload_progress_module do

  requires :apache, :git, :build_essential

  push_text "UploadProgressSharedMemorySize 1024000", "/etc/apache2/apache2.conf" do
    pre :install, "git clone http://github.com/drogus/apache-upload-progress-module.git aupm"
    pre :install, "sudo /usr/bin/apxs2 -c -i -a /root/aupm/mod_upload_progress.c"
    post :install, "sudo /etc/init.d/apache2 restart"
    post :install, "rm -rf /root/aupm"
  end

end
