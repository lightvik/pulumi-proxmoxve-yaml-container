wip

```
./pulumi bash
```

```
export PROJECT_NAME='infra.industrial.kz'
export PROJECT_DIRECTORY="/projects/${PROJECT_NAME}"
export PROJECT_DESCRIPTION="${PROJECT_NAME} - pulumi-proxmoxve"
export PROJECT_STACK="dev"
```

```
pulumi stack init \
--cwd "${PROJECT_DIRECTORY}" \
--stack "${PROJECT_STACK}"
```

```
mkdir --parents "${PROJECT_DIRECTORY}" \
&& \
pulumi new yaml \
--cwd "${PROJECT_DIRECTORY}" \
--name "${PROJECT_NAME}" \
--description "${PROJECT_DESCRIPTION}" \
--stack "${PROJECT_STACK}"
```




```
mkdir --parents "${PROJECT_DIRECTORY}"/files/{images,snippets,ssh_keys}
```

что-то о работе контейнера от рута и необходимости закинуть файлы в images,snippets,ssh_keys

```
find "${PROJECT_DIRECTORY}" -type d -exec chmod 777 {} +
find "${PROJECT_DIRECTORY}" -type f -exec chmod 666 {} +
```

что-то о заполнении images из проекта create_bootable_isfo_with_kickstart


```
cp --recursive /projects/example/jinja "${PROJECT_DIRECTORY}"
```


```
ssh-keygen \
-N '' \
-C "salt-ssh" \
-t ed25519 \
-f "${PROJECT_DIRECTORY}/files/ssh_keys/id_ed25519"
```

```
export SSH_PUBKEY="$(<${PROJECT_DIRECTORY}/files/ssh_keys/id_ed25519.pub)"
( cd "${PROJECT_DIRECTORY}/jinja" && jinjanate --quiet --output-file "${PROJECT_DIRECTORY}/files/snippets/cloud-init_root_with_password_and_private_key.yaml" cloud-init_root_with_password_and_private_key.yaml.j2; )
unset SSH_PUBKEY
```



создаем template vm

```
export TEMPLATE_VM_IS_NOT_READY=true
```

```
(
cd "${PROJECT_DIRECTORY}/jinja" \
&&
jinjanate \
--quiet \
--output-file "${PROJECT_DIRECTORY}/Pulumi.yaml" \
Pulumi.yaml.j2
) \
&& \
sed --in-place '/^[[:space:]]*$/d' "${PROJECT_DIRECTORY}/Pulumi.yaml"
```



```
pulumi up \
--cwd "${PROJECT_DIRECTORY}" \
--stack "${PROJECT_STACK}"
```

включаем template машину

```
export TEMPLATE_VM_IS_STARTED=true
```

```
pulumi refresh \
--skip-preview \
--cwd "${PROJECT_DIRECTORY}" \
--stack "${PROJECT_STACK}"
```


```
unset TEMPLATE_VM_IS_STARTED
```




```
unset TEMPLATE_VM_IS_NOT_READY
```








  132  pulumi refresh --cwd "${PROJECT_DIRECTORY}" --stack "${PROJECT_STACK}"
  133  pulumi up --cwd "${PROJECT_DIRECTORY}" --stack "${PROJECT_STACK}"

  106  export TEMPLATE_VM_IS_STARTED=false
  107  export TEMPLATE_VM_IS_NOT_READY=false

   96  pulumi down --cwd "${PROJECT_DIRECTORY}" --stack "${PROJECT_STACK}"







( cd "${PROJECT_DIRECTORY}/jinja" && jinjanate --quiet --output-file "${PROJECT_DIRECTORY}/ssh-config" ssh-config.j2; ) && sed '/[^[:blank:]]/,$!d' --in-place "${PROJECT_DIRECTORY}/ssh-config"


( cd "${PROJECT_DIRECTORY}/jinja" && jinjanate --quiet --output-file "${PROJECT_DIRECTORY}/roster.sls" roster.sls.j2; ) && sed '/[^[:blank:]]/,$!d' --in-place "${PROJECT_DIRECTORY}/roster.sls"
