[Coldsnap](https://github.com/awslabs/coldsnap) is not released as packaged binary anywhere and needs to be built manually. Most straightforward way of building as a portable statically linked binary (so it's more universal across different OSs with differing versions of GLIBC) is using docker, with musl as target

Dockerfile:
```Dockerfile
# needed to do mirror.gcr.io, because docker.io was really slow for some reason

FROM mirror.gcr.io/clux/muslrust:stable AS builder

WORKDIR /app
COPY . .

RUN cargo build --release --target x86_64-unknown-linux-musl

FROM scratch
COPY --from=builder /app/target/x86_64-unknown-linux-musl/release/coldsnap /coldsnap
```

```bash
$ sudo podman build -f Dockerfile -t coldsnap-musl .
[1/2] STEP 1/4: FROM mirror.gcr.io/clux/muslrust:stable AS builder
[1/2] STEP 2/4: WORKDIR /app
--> Using cache 9ba4f4ed7ebd5b210b51612029f850643eb4c5412981a99aa383335c01c7dcad
--> 9ba4f4ed7ebd
[1/2] STEP 3/4: COPY . .
WARN[0000] SHELL is not supported for OCI image format, [/bin/bash -eux -o pipefail -c] will be ignored. Must use `docker` format 
--> 66bf5260b2fa
[1/2] STEP 4/4: RUN cargo build --release --target x86_64-unknown-linux-musl
    Updating crates.io index
 Downloading crates ...
  Downloaded anstyle-query v1.1.2
  Downloaded anstream v0.6.18
  Downloaded argh_shared v0.1.13
  Downloaded aws-smithy-query v0.60.7
  Downloaded pin-project-lite v0.2.16
  Downloaded number_prefix v0.4.0
  Downloaded pin-utils v0.1.0
  Downloaded litemap v0.7.5
  Downloaded http-body v1.0.1
  Downloaded num-integer v0.1.46
  Downloaded is_terminal_polyfill v1.70.1
  Downloaded aws-credential-types v1.2.2
  Downloaded num-conv v0.1.0
  Downloaded autocfg v1.4.0
  Downloaded once_cell v1.21.3
  Downloaded equivalent v1.0.2
  Downloaded icu_provider_macros v1.5.0
  Downloaded cfg_aliases v0.2.1
  Downloaded colorchoice v1.0.3
  Downloaded outref v0.5.2
  Downloaded aws-smithy-json v0.61.3
  Downloaded bytes-utils v0.1.4
  Downloaded aws-smithy-observability v0.1.2
  Downloaded aws-smithy-async v1.2.5
  Downloaded futures-sink v0.3.31
  Downloaded aws-smithy-xml v0.60.9
  Downloaded aws-smithy-http v0.62.0
  Downloaded anstyle v1.0.10
  Downloaded block-buffer v0.10.4
  Downloaded atomic-waker v1.1.2
  Downloaded argh_derive v0.1.13
  Downloaded cmake v0.1.54
  Downloaded cfg-if v1.0.0
  Downloaded http-body v0.4.6
  Downloaded tower-layer v0.3.3
  Downloaded form_urlencoded v1.2.1
  Downloaded base64-simd v0.8.0
  Downloaded digest v0.10.7
  Downloaded hex v0.4.3
  Downloaded fastrand v2.3.0
  Downloaded futures-executor v0.3.31
  Downloaded futures-io v0.3.31
  Downloaded tower-service v0.3.3
  Downloaded futures-task v0.3.31
  Downloaded fnv v1.0.7
  Downloaded crypto-common v0.1.6
  Downloaded urlencoding v2.1.3
  Downloaded try-lock v0.2.5
  Downloaded generic-array v0.14.7
  Downloaded cpufeatures v0.2.17
  Downloaded aws-types v1.3.6
  Downloaded errno v0.3.10
  Downloaded anstyle-parse v0.2.6
  Downloaded either v1.15.0
  Downloaded write16 v1.0.0
  Downloaded dunce v1.0.5
  Downloaded want v0.3.1
  Downloaded zerofrom v0.1.6
  Downloaded futures-core v0.3.31
  Downloaded heck v0.5.0
  Downloaded futures-macro v0.3.31
  Downloaded http-body-util v0.1.3
  Downloaded env_filter v0.1.3
  Downloaded itoa v1.0.15
  Downloaded icu_locid_transform v1.5.0
  Downloaded async-trait v0.1.88
  Downloaded argh v0.1.13
  Downloaded getrandom v0.2.15
  Downloaded console v0.15.11
  Downloaded displaydoc v0.2.5
  Downloaded futures-channel v0.3.31
  Downloaded env_logger v0.11.8
  Downloaded idna_adapter v1.2.0
  Downloaded fs_extra v1.3.0
  Downloaded hyper-rustls v0.27.5
  Downloaded subtle v2.6.1
  Downloaded aws-sigv4 v1.3.0
  Downloaded deranged v0.4.1
  Downloaded rustc_version v0.4.1
  Downloaded powerfmt v0.2.0
  Downloaded icu_locid v1.5.0
  Downloaded time-core v0.1.4
  Downloaded icu_normalizer_data v1.5.1
  Downloaded hmac v0.12.1
  Downloaded icu_provider v1.5.0
  Downloaded percent-encoding v2.3.1
  Downloaded httparse v1.10.1
  Downloaded icu_locid_transform_data v1.5.1
  Downloaded icu_normalizer v1.5.0
  Downloaded jobserver v0.1.33
  Downloaded futures v0.3.31
  Downloaded aws-runtime v1.5.6
  Downloaded aws-smithy-http-client v1.0.1
  Downloaded bitflags v2.9.0
  Downloaded synstructure v0.13.1
  Downloaded getrandom v0.3.2
  Downloaded indicatif v0.17.11
  Downloaded icu_properties v1.5.1
  Downloaded tokio-macros v2.5.0
  Downloaded untrusted v0.9.0
  Downloaded openssl-probe v0.1.6
  Downloaded zerofrom-derive v0.1.6
  Downloaded yoke-derive v0.7.5
  Downloaded version_check v0.9.5
  Downloaded aws-smithy-runtime-api v1.7.4
  Downloaded writeable v0.5.5
  Downloaded zeroize v1.8.1
  Downloaded utf8_iter v1.0.4
  Downloaded utf16_iter v1.0.5
  Downloaded aws-smithy-types v1.3.0
  Downloaded utf8parse v0.2.2
  Downloaded icu_collections v1.5.0
  Downloaded vsimd v0.8.0
  Downloaded smallvec v1.14.0
  Downloaded bytes v1.10.1
  Downloaded base64 v0.22.1
  Downloaded sha2 v0.10.8
  Downloaded shlex v1.3.0
  Downloaded cc v1.2.17
  Downloaded indexmap v2.8.0
  Downloaded aws-smithy-runtime v1.8.1
  Downloaded stable_deref_trait v1.2.0
  Downloaded http v1.3.1
  Downloaded http v0.2.12
  Downloaded quote v1.0.40
  Downloaded hyper-util v0.1.11
  Downloaded rustls-native-certs v0.8.1
  Downloaded slab v0.4.9
  Downloaded tinystr v0.7.6
  Downloaded time-macros v0.2.22
  Downloaded tempfile v3.19.1
  Downloaded aws-config v1.6.1
  Downloaded hashbrown v0.15.2
  Downloaded aws-sdk-ebs v1.64.0
  Downloaded snafu-derive v0.8.5
  Downloaded idna v1.0.3
  Downloaded tracing-attributes v0.1.28
  Downloaded hyper v1.6.0
  Downloaded futures-util v0.3.31
  Downloaded tokio-rustls v0.26.2
  Downloaded aho-corasick v1.1.3
  Downloaded aws-sdk-sts v1.65.0
  Downloaded h2 v0.4.8
  Downloaded yoke v0.7.5
  Downloaded xmlparser v0.13.6
  Downloaded semver v1.0.26
  Downloaded aws-lc-rs v1.13.0
  Downloaded zerovec-derive v0.10.3
  Downloaded num-traits v0.2.19
  Downloaded icu_properties_data v1.5.1
  Downloaded serde_derive v1.0.219
  Downloaded unicode-ident v1.0.18
  Downloaded log v0.4.27
  Downloaded ryu v1.0.20
  Downloaded rustls-pki-types v1.11.0
  Downloaded snafu v0.8.5
  Downloaded proc-macro2 v1.0.94
  Downloaded socket2 v0.5.9
  Downloaded libc v0.2.171
  Downloaded uuid v1.16.0
  Downloaded serde v1.0.219
  Downloaded tracing v0.1.41
  Downloaded tracing-core v0.1.33
  Downloaded url v2.5.4
  Downloaded memchr v2.7.4
  Downloaded regex-lite v0.1.6
  Downloaded typenum v1.18.0
  Downloaded mio v1.0.3
  Downloaded tower v0.5.2
  Downloaded tokio-util v0.7.14
  Downloaded zerovec v0.10.4
  Downloaded time v0.3.41
  Downloaded portable-atomic v1.11.0
  Downloaded regex v1.11.1
  Downloaded unicode-width v0.2.0
  Downloaded syn v2.0.100
  Downloaded rustls v0.23.25
  Downloaded nix v0.29.0
  Downloaded regex-syntax v0.8.5
  Downloaded rustix v1.0.5
  Downloaded regex-automata v0.4.9
  Downloaded jiff v0.2.5
  Downloaded aws-sdk-ec2 v1.121.0
  Downloaded rustls-webpki v0.103.1
  Downloaded tokio v1.44.1
  Downloaded rust-fuzzy-search v0.1.1
  Downloaded aws-lc-sys v0.28.0
  Downloaded ring v0.17.14
  Downloaded linux-raw-sys v0.9.3
   Compiling proc-macro2 v1.0.94
   Compiling unicode-ident v1.0.18
   Compiling libc v0.2.171
   Compiling autocfg v1.4.0
   Compiling pin-project-lite v0.2.16
   Compiling bytes v1.10.1
   Compiling futures-core v0.3.31
   Compiling futures-sink v0.3.31
   Compiling fnv v1.0.7
   Compiling itoa v1.0.15
   Compiling memchr v2.7.4
   Compiling once_cell v1.21.3
   Compiling pin-utils v0.1.0
   Compiling futures-io v0.3.31
   Compiling futures-task v0.3.31
   Compiling futures-channel v0.3.31
   Compiling slab v0.4.9
   Compiling http v1.3.1
   Compiling num-traits v0.2.19
   Compiling shlex v1.3.0
   Compiling tracing-core v0.1.33
   Compiling quote v1.0.40
   Compiling socket2 v0.5.9
   Compiling mio v1.0.3
   Compiling zeroize v1.8.1
   Compiling jobserver v0.1.33
   Compiling powerfmt v0.2.0
   Compiling syn v2.0.100
   Compiling http-body v1.0.1
   Compiling cc v1.2.17
   Compiling deranged v0.4.1
   Compiling http v0.2.12
   Compiling vsimd v0.8.0
   Compiling num-conv v0.1.0
   Compiling dunce v1.0.5
   Compiling outref v0.5.2
   Compiling time-core v0.1.4
   Compiling fs_extra v1.3.0
   Compiling either v1.15.0
   Compiling num-integer v0.1.46
   Compiling cmake v0.1.54
   Compiling base64-simd v0.8.0
   Compiling time v0.3.41
   Compiling http-body-util v0.1.3
   Compiling bytes-utils v0.1.4
   Compiling http-body v0.4.6
   Compiling ryu v1.0.20
   Compiling aws-lc-sys v0.28.0
   Compiling subtle v2.6.1
   Compiling aws-lc-rs v1.13.0
   Compiling synstructure v0.13.1
   Compiling typenum v1.18.0
   Compiling smallvec v1.14.0
   Compiling version_check v0.9.5
   Compiling stable_deref_trait v1.2.0
   Compiling httparse v1.10.1
   Compiling equivalent v1.0.2
   Compiling hashbrown v0.15.2
   Compiling rustls-pki-types v1.11.0
   Compiling try-lock v0.2.5
   Compiling generic-array v0.14.7
   Compiling tokio-macros v2.5.0
   Compiling futures-macro v0.3.31
   Compiling tracing-attributes v0.1.28
   Compiling zerofrom-derive v0.1.6
   Compiling yoke-derive v0.7.5
   Compiling zerovec-derive v0.10.3
   Compiling indexmap v2.8.0
   Compiling tokio v1.44.1
   Compiling futures-util v0.3.31
   Compiling tracing v0.1.41
   Compiling displaydoc v0.2.5
   Compiling zerofrom v0.1.6
   Compiling untrusted v0.9.0
   Compiling yoke v0.7.5
   Compiling atomic-waker v1.1.2
   Compiling rustls v0.23.25
   Compiling semver v1.0.26
   Compiling zerovec v0.10.4
   Compiling want v0.3.1
   Compiling cfg-if v1.0.0
   Compiling tower-service v0.3.3
   Compiling percent-encoding v2.3.1
   Compiling crypto-common v0.1.6
   Compiling block-buffer v0.10.4
   Compiling writeable v0.5.5
   Compiling icu_locid_transform_data v1.5.1
   Compiling openssl-probe v0.1.6
   Compiling litemap v0.7.5
   Compiling digest v0.10.7
   Compiling rustc_version v0.4.1
   Compiling icu_provider_macros v1.5.0
   Compiling tinystr v0.7.6
   Compiling rustls-native-certs v0.8.1
   Compiling serde v1.0.219
   Compiling tokio-util v0.7.14
   Compiling aws-smithy-async v1.2.5
   Compiling icu_locid v1.5.0
   Compiling tower-layer v0.3.3
   Compiling icu_properties_data v1.5.1
   Compiling aws-types v1.3.6
   Compiling tower v0.5.2
   Compiling form_urlencoded v1.2.1
   Compiling fastrand v2.3.0
   Compiling icu_normalizer_data v1.5.1
   Compiling aws-smithy-types v1.3.0
   Compiling h2 v0.4.8
   Compiling icu_provider v1.5.0
   Compiling cpufeatures v0.2.17
   Compiling sha2 v0.10.8
   Compiling hmac v0.12.1
   Compiling icu_collections v1.5.0
   Compiling serde_derive v1.0.219
   Compiling aws-smithy-runtime-api v1.7.4
   Compiling icu_locid_transform v1.5.0
   Compiling hex v0.4.3
   Compiling hyper v1.6.0
   Compiling aws-smithy-http v0.62.0
   Compiling aws-credential-types v1.2.2
   Compiling aws-smithy-observability v0.1.2
   Compiling aws-sigv4 v1.3.0
   Compiling hyper-util v0.1.11
   Compiling icu_properties v1.5.1
   Compiling utf16_iter v1.0.5
   Compiling uuid v1.16.0
   Compiling write16 v1.0.0
   Compiling utf8_iter v1.0.4
   Compiling aws-smithy-json v0.61.3
   Compiling aho-corasick v1.1.3
   Compiling urlencoding v2.1.3
   Compiling regex-lite v0.1.6
   Compiling icu_normalizer v1.5.0
   Compiling regex-syntax v0.8.5
   Compiling xmlparser v0.13.6
   Compiling aws-smithy-query v0.60.7
   Compiling getrandom v0.3.2
   Compiling idna_adapter v1.2.0
   Compiling aws-smithy-xml v0.60.9
   Compiling rustix v1.0.5
   Compiling bitflags v2.9.0
   Compiling regex-automata v0.4.9
   Compiling cfg_aliases v0.2.1
   Compiling utf8parse v0.2.2
   Compiling portable-atomic v1.11.0
   Compiling argh_shared v0.1.13
   Compiling nix v0.29.0
   Compiling anstyle-parse v0.2.6
   Compiling idna v1.0.3
   Compiling linux-raw-sys v0.9.3
   Compiling unicode-width v0.2.0
   Compiling is_terminal_polyfill v1.70.1
   Compiling colorchoice v1.0.3
   Compiling anstyle-query v1.1.2
   Compiling heck v0.5.0
   Compiling anstyle v1.0.10
   Compiling log v0.4.27
   Compiling url v2.5.4
   Compiling regex v1.11.1
   Compiling anstream v0.6.18
   Compiling snafu-derive v0.8.5
   Compiling env_filter v0.1.3
   Compiling console v0.15.11
   Compiling argh_derive v0.1.13
   Compiling futures-executor v0.3.31
   Compiling jiff v0.2.5
   Compiling number_prefix v0.4.0
   Compiling rust-fuzzy-search v0.1.1
   Compiling futures v0.3.31
   Compiling tempfile v3.19.1
   Compiling indicatif v0.17.11
   Compiling argh v0.1.13
   Compiling snafu v0.8.5
   Compiling async-trait v0.1.88
   Compiling base64 v0.22.1
   Compiling env_logger v0.11.8
   Compiling rustls-webpki v0.103.1
   Compiling tokio-rustls v0.26.2
   Compiling hyper-rustls v0.27.5
   Compiling aws-smithy-http-client v1.0.1
   Compiling aws-smithy-runtime v1.8.1
   Compiling aws-runtime v1.5.6
   Compiling aws-sdk-sts v1.65.0
   Compiling aws-sdk-ebs v1.64.0
   Compiling aws-sdk-ec2 v1.121.0
   Compiling aws-config v1.6.1
   Compiling coldsnap v0.7.0 (/app)
    Finished `release` profile [optimized] target(s) in 4m 07s
WARN[0250] SHELL is not supported for OCI image format, [/bin/bash -eux -o pipefail -c] will be ignored. Must use `docker` format 
--> d2e7a0504bb9
[2/2] STEP 1/2: FROM scratch
[2/2] STEP 2/2: COPY --from=builder /app/target/x86_64-unknown-linux-musl/release/coldsnap /coldsnap
--> Using cache bed72207f9e9c651b1f740f8aa9d24a81bd2092fa47fd2529c7b141450ae725b
[2/2] COMMIT coldsnap-musl
--> bed72207f9e9
Successfully tagged localhost/coldsnap-musl:latest
bed72207f9e9c651b1f740f8aa9d24a81bd2092fa47fd2529c7b141450ae725b

$ sudo podman create coldsnap-musl
fb7a5c8356c9809747f1843a500f33b0bb49f9f2a4648a4712d96b64633ad6e7

$ sudo podman cp "fb7a5c8356c9809747f1843a500f33b0bb49f9f2a4648a4712d96b64633ad6e7:/coldsnap" ./coldsnap

$ file coldsnap 
coldsnap: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), static-pie linked, BuildID[sha1]=08de087142a4f6aa637226b3df4ee59a0b144065, not stripped

$ ./coldsnap 
One of the following subcommands must be present:
    help
    download
    upload
    wait

Run coldsnap --help for more information.
```
