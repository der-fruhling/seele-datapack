set unstable
set lists

all-resources := [
    "Dungeons and Taverns v6.1.0.zip",
    "MRN-26-3.zip",
    "VanillaTweaks_r487722_MC26.3.x.zip",
    "enchantments_encore_6.1.zip",
    "roman-numerals.zip",
    "visual_armor_trims_4.3.zip",
    "Home Brewed 1.0.2.zip",
    "vane-v1.23.0.zip"
]

archive:
    zip -r9 seele-datapack.zip data pack.mcmeta

clean-resources:
    rm -rf resources/staging

unzip file:
    rm -rf "resources/extracted/{{ file_stem(file) }}"
    mkdir -p "resources/extracted/{{ file_stem(file) }}"
    unzip "resources/{{ file }}" "assets/*" -d "resources/extracted/{{ file_stem(file) }}"

[parallel]
extract: *(unzip *all-resources)

merge-lang dir:
    ./merge-lang.sh "{{ dir }}"

merge dir: (merge-lang ("resources/extracted/" + file_stem(dir)))
    ./merge.sh "{{ "resources/extracted/" + file_stem(dir) }}"

prepare-package:
    cp resources.mcmeta resources/staging/pack.mcmeta

[working-directory("resources/staging")]
package:
    zip -r ../../resources.zip assets pack.mcmeta

resources: clean-resources extract *(merge *all-resources) prepare-package package

publish-resources:
    rclone copy resources.zip r2:seele-meta/
    sha1sum resources.zip
