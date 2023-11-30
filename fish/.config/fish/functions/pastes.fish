# pastes.dxuuu.xyz helper
function pastes
    if test -t 0
        echo "^C to cancel, ^D to send"
    end
    curl https://pastes.dxuuu.xyz --data-binary '@-'
end
