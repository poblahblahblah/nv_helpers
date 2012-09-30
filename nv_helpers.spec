# RedHat RPM package spec file
Summary: helper scripts for dealing with nVentory
Name: nv_helpers
# Version: This must be the version string from the rpm filename you plan to 
# use.  This is replaced at rpm build time with NvHelpers::VERSION.
Version: NvHelpers::VERSION 
# Release: This is the release number for a package of the same version (ie. if 
# we make a package and find it to be slightly broken and need to make it 
# again, the next package would be release number 2).
Release: 1
License: Proprietary
Group: System/Tools
URL: http://www.eharmony.com/
Requires: ruby, nventory-client
BuildRoot: %{_builddir}/%{name}-buildroot
BuildArch: noarch

%description
This package includes helper scripts for dealing with nVentory

%files
%defattr(-,root,root)
/usr/lib/ruby/site_ruby/1.8/nv_helpers/*.rb
/usr/lib/ruby/site_ruby/1.8/nv_helpers.rb
