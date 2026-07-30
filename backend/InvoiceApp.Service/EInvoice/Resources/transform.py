import sys

from saxonche import PySaxonProcessor


def main() -> int:
    stylesheet_path = sys.argv[1]
    xml_path = sys.argv[2]

    with PySaxonProcessor(license=False) as proc:
        xslt_proc = proc.new_xslt30_processor()
        executable = xslt_proc.compile_stylesheet(stylesheet_file=stylesheet_path)
        result = executable.transform_to_string(source_file=xml_path)

    sys.stdout.write(result)
    return 0


if __name__ == "__main__":
    sys.exit(main())
