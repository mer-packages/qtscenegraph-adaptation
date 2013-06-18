Name:       qtscenegraph-adaptation
Summary:    Scenegraph adaptation from playground
Version:    git
Release:    1%{?dist}
Group:      Qt/Qt
License:    LGPLv2.1 with exception or GPLv3
URL:        http://qt.nokia.com
Source0:    %{name}-%{version}.tar.bz2
BuildRequires:  qt5-qtcore-devel
BuildRequires:  qt5-qtgui-devel
BuildRequires:  qt5-qtwidgets-devel
BuildRequires:  qt5-qtopengl-devel
BuildRequires:  qt5-qtnetwork-devel
BuildRequires:  qt5-qtdeclarative-devel
BuildRequires:  qt5-qtdeclarative-qtquick-devel
BuildRequires:  qt5-qmake
BuildRequires:  qt5-qtv8-devel
BuildRequires:  fdupes

%description
Qt is a cross-platform application and UI framework. Using Qt, you can
write web-enabled applications once and deploy them across desktop,
mobile and embedded systems without rewriting the source code.
.
This package contains the Qt location module

#### Build section

%prep
%setup -q -n %{name}-%{version}/scenegraph

%build
export QTDIR=/usr/share/qt5
%qmake5 "CONFIG+= atlastexture overlaprenderer"

%install
rm -rf %{buildroot}
%qmake5_install

#### Pre/Post section

%post
/sbin/ldconfig
%postun
/sbin/ldconfig




#### File section


%files
%defattr(-,root,root,-)
%{_libdir}/qt5/imports/Animators/libanimators.so
%{_libdir}/qt5/imports/Animators/qmldir
%{_libdir}/qt5/plugins/scenegraph/libcustomcontext.so


#### No changelog section, separate $pkg.changelog contains the history
