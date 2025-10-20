function ssh_new
    read -P "Enter comment/email for SSH key: " comment

    read -P "Enter a name for the key file (e.g., github): " keyname
    set keyfile ~/.ssh/$keyname

    ssh-keygen -t ed25519 -C "$comment" -f $keyfile

    read -P "Do you want to show the public key? (y/n): " choice

    if test "$choice" = "y"
            cat ~/.ssh/$keyname.pub
    end
end
