# RedHat RPM tasks for rake

desc 'Build an etch client RPM on a Red Hat box'
task :redhat => [:redhatprep, :rpm]


desc 'Prep a Red Hat box for building an RPM'
task :redhatprep do
  # Install the package which contains the rpmbuild command
  system('rpm --quiet -q rpm-build || sudo yum install rpm-build')
end


desc 'Build an etch client RPM'
task :rpm do
  #
  # Create package file structure in build root
  #

  rm_rf(BUILDROOT)
  libdir = File.join(BUILDROOT, 'usr', 'lib', 'ruby', 'site_ruby', '1.8', 'nv_helpers')
  mkdir_p(libdir)
  cp('nv_helpers/node_group_helper.rb', libdir)
  cp('nv_helpers/graffiti_helper.rb', libdir)
  cp('nv_helpers/nv_wrapper.rb', libdir)
  cp('nv_helpers.rb', File.dirname(libdir))

  #
  # Prep spec file
  #
  spec = Tempfile.new('nv_helpersrpm')
  IO.foreach('nv_helpers.spec') do |line|
#    line.sub!('%VER%', VERSION)
    spec.puts(line)
  end
  spec.close

  #
  # Build the package
  #

  system("rpmbuild -bb --buildroot #{BUILDROOT} #{spec.path}")

  #
  # Cleanup
  #

  rm_rf(BUILDROOT)
end
