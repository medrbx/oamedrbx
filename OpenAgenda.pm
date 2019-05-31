package OpenAgenda;

use Moo;
use LWP::UserAgent;
use JSON;
use YAML qw(LoadFile);

has api_url => ( is => 'rw');
has agendaUid => ( is => 'rw');
has private_key => ( is => 'rw');
has public_key => ( is => 'rw');
has access_token => ( is => 'rw');

has event => ( is => 'rw');

sub BUILDARGS {
    my ($class, @args) = @_;
    my $arg;
    
    if ( $args[0]->{med_oa} ) {
        my %params = %{$args[0]->{med_oa}};
        foreach my $k (keys(%params)) {
                $arg->{$k} = $params{$k};
        }
    } else {
        $arg = _get_dataconf();
    }

    return $arg;
}

sub get_oa_access_token {
    my ($self) = @_;
    my $url = $self->{api_url} . "/v1/requestAccessToken";
    my $form = {
        'grant_type' => 'authorization_code', 
        'code' => $self->{private_key}
    };

    my $ua = LWP::UserAgent->new();
    my $res = $ua->post( $url, $form );
    my $token_data = $res->decoded_content;
    $token_data = decode_json($token_data);

    $self->{access_token} = $token_data->{access_token};

    return $self;
}

sub add_event {
    my ($self, $event) = @_;
    
    my $json_event = encode_json($event);
    my $route = "/v2/agendas/" . $self->{agendaUid} . "/events";
    my $url = $self->{api_url} . $route;
    my $nonce = _get_nonce();    
    my $form = {
        access_token => $self->{access_token},
        nonce => $nonce,
        data => $json_event
    };    
    
    my $ua = LWP::UserAgent->new();
    my $res = $ua->post( $url, $form, 'Content-type' => 'text/plain' );
    return $res->decoded_content;
}

sub _get_nonce {
    my $range = 1000;

    return int(rand($range));
}

sub _get_dataconf {
    my $file = "oa_conf.yaml";
    my $dataconf = LoadFile($file);
    return $dataconf;
}

1;
