function ssh_new
    # Ask for comment/email
    read -P "Enter comment/email for SSH key: " comment

    # Ask for filename and prepend ~/.ssh/ automatically
    read -P "Enter a name for the key file (e.g., github): " keyname
    set keyfile ~/.ssh/$keyname

    # Generate the key
    ssh-keygen -t ed25519 -C "$comment" -f $keyfile

    # Ask if user wants to show the public key
    read -P "Do you want to show the public key? (y/n): " choice

    if test "$choice" = "y"
            cat ~/.ssh/$keyname.pub
    end
end
