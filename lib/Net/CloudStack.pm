package Net::CloudStack;

use 5.006;

use Moose;
use Moose::Util::TypeConstraints;
use Digest::SHA qw(hmac_sha1);
use MIME::Base64;
use WWW::Mechanize;
use Encode;
use XML::Twig;
use URI::Encode;
use JSON;
use Carp;

subtype 'CloudStack::Flag3'
    => as 'Int'
    => where { $_ >= 1 && $_ <= 3 }
=> message { "Please input[1-3](1:gen_url,2:response,3:both)" }
;

has 'base_url' => ( #http://localhost:8080
    is => 'rw',
    isa => 'Str',
    required => 1,
    );

has 'api_path' => ( #/client/api?
    is => 'rw',
    isa => 'Str',
    required => 1,
    );

has 'api_key' => (
    is => 'rw',
    isa => 'Str',
    required => 1,
    );

has 'secret_key' => (
    is => 'rw',
    isa => 'Str',
    required => 1,
    );

has 'url_response' => ( #1:gen_url,2:response,3:both
    is => 'rw',
    isa => 'CloudStack::Flag3',
    default => 3,
    );

has 'xml_json' => (
    is => 'rw',
    isa => 'Str',
    default => 'xml',
    );

__PACKAGE__->meta->make_immutable;
no Moose;
no Moose::Util::TypeConstraints;

### FOR TEST ###

sub test{
    my ($self,$opt) = @_;
    my @required = ();

    print "BASE URL:".$self->base_url."\n";
    print "API PATH:".$self->api_path."\n";
    print "OPT:".$opt."\n";
    print "API KEY:".$self->api_key."\n";
    print "SECRET KEY:".$self->secret_key."\n";
    print "URL_RESPONSE:".$self->url_response."\n";
    print "XML_JSON:".$self->xml_json."\n";

    &output($self, $opt, \@required);
}

### COMMAND ###
### VirtualMachine ###
sub deployVirtualMachine{
    my ($self, $opt) = @_;
    my @required = ("serviceofferingid", "templateid", "zoneid");
    &output($self, $opt, \@required);
}
sub destroyVirtualMachine{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub rebootVirtualMachine{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub startVirtualMachine{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub stopVirtualMachine{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub resetPasswordForVirtualMachine{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub changeServiceForVirtualMachine{
    my ($self, $opt) = @_;
    my @required = ("id","serviceofferingid");
    &output($self, $opt, \@required);
}
sub updateVirtualMachine{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub listVirtualMachines{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}
sub getVMPassword{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}

### Template ###
sub createTemplate{
    my ($self, $opt) = @_;
    my @required = ("displaytext","name","ostypeid");
    &output($self, $opt, \@required);
}
sub registerTemplate{
    my ($self, $opt) = @_;
    my @required = ("displaytext","format","hypervisor","name","ostypeid","url","zoneid");
    &output($self, $opt, \@required);
}
sub updateTemplate{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub copyTemplate{
    my ($self, $opt) = @_;
    my @required = ("id","destzoneid","sourcezoneid");
    &output($self, $opt, \@required);
}
sub deleteTemplate{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub listTemplates{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}
sub updateTemplatePermissions{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub listTemplatePermissions{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub extractTemplate{
    my ($self, $opt) = @_;
    my @required = ("id","mode","zoneid");
    &output($self, $opt, \@required);
}

### ISO ###
sub attachIso{
    my ($self, $opt) = @_;
    my @required = ("id","virtualmachineid");
    &output($self, $opt, \@required);
}
sub detachIso{
    my ($self, $opt) = @_;
    my @required = ("virtualmachineid");
    &output($self, $opt, \@required);
}
sub listIsos{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}
sub registerIso{
    my ($self, $opt) = @_;
    my @required = ("displaytext","name","url","zoneid");
    &output($self, $opt, \@required);
}
sub updateIso{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub deleteIso{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub copyIso{
    my ($self, $opt) = @_;
    my @required = ("id","destzoneid","sourcezoneid");
    &output($self, $opt, \@required);
}
sub updateIsoPermissions{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub listIsoPermissions{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub extractIso{
    my ($self, $opt) = @_;
    my @required = ("id","mode","zoneid");
    &output($self, $opt, \@required);
}

### Volume ###
sub attachVolume{
    my ($self, $opt) = @_;
    my @required = ("id","virtualmachineid");
    &output($self, $opt, \@required);
}
sub detachVolume{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}
sub createVolume{
    my ($self, $opt) = @_;
    my @required = ("name");
    &output($self, $opt, \@required);
}
sub deleteVolume{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub listVolumes{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}
sub extractVolume{
    my ($self, $opt) = @_;
    my @required = ("id","mode","zoneid");
    &output($self, $opt, \@required);
}

### Security Group ###
sub createSecurityGroup{
    my ($self, $opt) = @_;
    my @required = ("name");
    &output($self, $opt, \@required);
}
sub deleteSecurityGroup{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}
sub authorizeSecurityGroupIngress{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}
sub revokeSecurityGroupIngress{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub listSecurityGroups{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}

### Account ###
sub listAccounts{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}

### Snapshot ###
sub createSnapshot{
    my ($self, $opt) = @_;
    my @required = ("volumeid");
    &output($self, $opt, \@required);
}
sub listSnapshots{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}
sub deleteSnapshot{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub createSnapshotPolicy{
    my ($self, $opt) = @_;
    my @required = ("intervaltype","maxsnaps","schedule","timezone","volumeid");
    &output($self, $opt, \@required);
}
sub deleteSnapshotPolicies{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}
sub listSnapshotPolicies{
    my ($self, $opt) = @_;
    my @required = ("volumeid");
    &output($self, $opt, \@required);
}

### Async job ###
sub queryAsyncJobResult{
    my ($self, $opt) = @_;
    my @required = ("jobid");
    &output($self, $opt, \@required);
}
sub listAsyncJobs{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}

### Event ###
sub listEvents{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}
sub listEventTypes{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}

### Guest OS ###
sub listOsTypes{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}
sub listOsCategories{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}

### Service Offering ###
sub listServiceOfferings{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}

### Disk Offering ###
sub listDiskOfferings{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}

### SSH ###
sub registerSSHKeyPair{
    my ($self, $opt) = @_;
    my @required = ("name","publickey");
    &output($self, $opt, \@required);
}
sub createSSHKeyPair{
    my ($self, $opt) = @_;
    my @required = ("name");
    &output($self, $opt, \@required);
}
sub deleteSSHKeyPair{
    my ($self, $opt) = @_;
    my @required = ("name");
    &output($self, $opt, \@required);
}
sub listSSHKeyPairs{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}

### Address ###
sub associateIpAddress{
    my ($self, $opt) = @_;
    my @required = ("zoneid");
    &output($self, $opt, \@required);
}
sub disassociateIpAddress{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub listPublicIpAddresses{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}

### Firewall ###
sub listPortForwardingRules{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}
sub createPortForwardingRule{
    my ($self, $opt) = @_;
    my @required = ("privateport","protocol","publicport","virtualmachineid");
    &output($self, $opt, \@required);
}
sub deletePortForwardingRule{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub createFirewallRule{
    my ($self, $opt) = @_;
    my @required = ("ipaddressid","protocol");
    &output($self, $opt, \@required);
}
sub deleteFirewallRule{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub listFirewallRules{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}

### NAT ###
sub enableStaticNat{
    my ($self, $opt) = @_;
    my @required = ("ipaddressid","virtualmachineid");
    &output($self, $opt, \@required);
}
sub createIpForwardingRule{
    my ($self, $opt) = @_;
    my @required = ("ipaddressid","protocol","startport");
    &output($self, $opt, \@required);
}
sub deleteIpForwardingRule{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub listIpForwardingRules{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}
sub disableStaticNat{
    my ($self, $opt) = @_;
    my @required = ("ipaddressid");
    &output($self, $opt, \@required);
}

### Load Balancer ###
sub createLoadBalancerRule{
    my ($self, $opt) = @_;
    my @required = ("algorithm","name","privateport","publicport");
    &output($self, $opt, \@required);
}
sub deleteLoadBalancerRule{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub removeFromLoadBalancerRule{
    my ($self, $opt) = @_;
    my @required = ("id","virtualmachineids");
    &output($self, $opt, \@required);
}
sub assignToLoadBalancerRule{
    my ($self, $opt) = @_;
    my @required = ("id","virtualmachineids");
    &output($self, $opt, \@required);
}
sub listLoadBalancerRules{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}
sub listLoadBalancerRuleInstances{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub updateLoadBalancerRule{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}

### VM group ###
sub createInstanceGroup{
    my ($self, $opt) = @_;
    my @required = ("name");
    &output($self, $opt, \@required);
}
sub deleteInstanceGroup{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub updateInstanceGroup{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub listInstanceGroups{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}

### Network ###
sub createNetwork{
    my ($self, $opt) = @_;
    my @required = ("displaytext","name","networkofferingid","zoneid");
    &output($self, $opt, \@required);
}
sub deleteNetwork{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub listNetworks{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}
sub restartNetwork{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}
sub updateNetwork{
    my ($self, $opt) = @_;
    my @required = ("id");
    &output($self, $opt, \@required);
}

### VPN ###
sub createRemoteAccessVpn{
    my ($self, $opt) = @_;
    my @required = ("publicipid");
    &output($self, $opt, \@required);
}
sub deleteRemoteAccessVpn{
    my ($self, $opt) = @_;
    my @required = ("publicipid");
    &output($self, $opt, \@required);
}
sub listRemoteAccessVpns{
    my ($self, $opt) = @_;
    my @required = ("publicipid");
    &output($self, $opt, \@required);
}
sub addVpnUser{
    my ($self, $opt) = @_;
    my @required = ("password","username");
    &output($self, $opt, \@required);
}
sub remoteVpnUser{
    my ($self, $opt) = @_;
    my @required = ("username");
    &output($self, $opt, \@required);
}
sub listVpnUsers{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}

### Hypervisors ###
sub listHypervisors{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}

### Zone ###
sub listZones{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}

### Network Offering ###
sub listNetworkOfferings{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}

### Configuration ###
sub listCapabilities{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}

### Limit ###
sub listResourceLimits{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}

### Cloud Identifier ###
sub getCloudIdentifier{
    my ($self, $opt) = @_;
    my @required = ("userid");
    &output($self, $opt, \@required);
}

### Login ###
sub login{
    my ($self, $opt) = @_;
    my @required = ("username","password");
    &output($self, $opt, \@required);
}

### Logout ###
sub logout{
    my ($self, $opt) = @_;
    my @required = ();
    &output($self, $opt, \@required);
}

### SUB ROUTINE ###
sub gen_url{
    my ($base_url, $api_path, $cmd, $opt, $api_key, $secret_key, $xml_json) = @_;
    my $uri = URI::Encode->new();

#step1
    if($opt){
        $cmd .= "&".$opt;
    }
    if($xml_json =~ /json/){
        $cmd .= "&response=json";
    }
    my $query = "command=".$cmd."&apiKey=".$api_key;
    my @list = split(/&/,$query);
    foreach  (@list){
        if(/(.+)\=(.+)/){
            my $field = $1;
            my $value = $uri->encode($2, 1); # encode_reserved option is set to 1
            $_ = $field."=".$value;
        }
    }

#step2
    foreach  (@list){
        $_ = lc($_);
    }
    my $output = join("&",sort @list);

#step3
    my $digest = hmac_sha1($output, $secret_key);
    my $base64_encoded = encode_base64($digest);chomp($base64_encoded);
    my $url_encoded = $uri->encode($base64_encoded, 1); # encode_reserved option is set to 1
    my $url = $base_url."/".$api_path."apikey=".$api_key."&command=".$cmd."&signature=".$url_encoded;
    return $url;
}

sub output{
    my ($self, $opt, $required) = @_;

    if(!defined($opt)){
        $opt = "";
    }
    else{
        $opt =~ s/([\=\&])\s+/$1/g;
        $opt =~ s/\s+([\=\&])/$1/g;
    }

    my $cmd = (caller 1)[3];
    $cmd =~ s/.*:://;

	foreach (@$required){
	    croak "$_ is required"  if(!defined($opt) || $opt !~ /[\s\&]*$_\s*\=/);
	}

	my $url = &gen_url($self->base_url, $self->api_path, $cmd, $opt, $self->api_key, $self->secret_key, $self->xml_json);
	if($self->url_response == 1 || $self->url_response ==3){
	    &print_url($url);
	}
	if($self->url_response == 2 || $self->url_response ==3){
	    &print_response($url);
	}
    }

sub print_url{
    my ($url) = shift;
    print "\nGenerate URL...\n".$url."\n\n";
}

sub print_response{
    my ($url) = shift;
    my $mech = WWW::Mechanize->new();
    $mech->get($url);

    if($url =~ /response=json/){#json
        my $obj = from_json($mech->content);
        my $json = JSON->new->pretty(1)->encode($obj);
        print $json;
    }

    else{#XML
        my $xml = encode('utf8',$mech->content);#cp932 for Win
	my $twig = XML::Twig->new(pretty_print => 'indented', );
        $twig->parse($xml);
        $twig->print;

    }
}



=head1 NAME

Net::CloudStack - Bindings for the CloudStack API

=head1 VERSION

Version 0.00004

=cut

our $VERSION = '0.00004';


=head1 SYNOPSIS

    use Net::CloudStack;
    my $api = Net::CloudStack->new(
        base_url        => 'http://...',
        api_path        => 'client/api?',
        api_key         => '<your api key>',
        secret_key      => '<your secret key>',
        url_response    => 3,
    );
    $api->listVirtualMachines();

=head1 METHODS

=head2 listVirtualMachines

    listVirtualMachines()
    listVirtualMachines("id=$id")

=head2 deployVirtualMachine

    deployVirtualMachine("serviceoffeingid=$serviceoffeingid&templateid=$templateid&zoneid=$zoneid")

=head2 startVirtualMachine/stopVirtualMachine

    startVirtualMachine("id=$id")
    stopVirtualMachine("id=$id")

Please refer B<API Reference> in following B<Developer's Guide:CloudStack>.


=head1 AUTHOR

Shugo Numano, C<< <numano at cc.rim.or.jp> >>

@shugonumano

=head1 BUGS

Please report any bugs or feature requests to C<bug-net-cloudstack at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Net-CloudStack>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Net::CloudStack


You can also look for information at:

=over 5

=item * Developer's Guide:CloudStack

L<http://docs.cloud.com/CloudStack_Documentation/Developer%27s_Guide%3A_CloudStack>

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Net-CloudStack>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Net-CloudStack>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Net-CloudStack>

=item * Search CPAN

L<http://search.cpan.org/dist/Net-CloudStack/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Shugo Numano.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of Net::CloudStack
