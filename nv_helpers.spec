Summary: helper scripts for dealing with nVentory
Name: nv_helpers
Version: 1.1
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
