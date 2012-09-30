# RedHat RPM tasks for rake

BUILD_VERSION = NvHelpers::VERSION
BUILD_RELEASE = NvHelpers::VERSION.split('.').last
BUILDROOT = '/var/tmp/nv_helpers-buildroot/'

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

  # copy files from lib/ up into nv_helpers level for ruby site lib
  (Dir.glob("lib/**/*rb") - ["lib/nv_helpers.rb"]).each do |f|
    cp(f, libdir)
  end
  # do this file separately - it loads the others
  cp('lib/nv_helpers.rb', File.dirname(libdir))

  #
  # Prep spec file
  #
  spec = Tempfile.new('nv_helpersrpm')
  IO.foreach('nv_helpers.spec') do |line|
    # TODO: does the RPM Version only include first two numbers? also see 
    # Release number
    line.gsub!(/^Version: .*$/,
               "Version: #{BUILD_VERSION}")
    # TODO: use last digit of version as Release number?
    line.gsub!(/^Release: .*$/,
               "Release: #{BUILD_RELEASE}")
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
