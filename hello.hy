(import [trytond.pool [Pool]]
        [trytond.model [fields ModelSQL ModelView]]
        [sql [*]]
        [sql.aggregate [*]]
        [sql.conditionals [*]]
        [sql.functions [CurrentTimestamp]])

(defclass  HelloSummaryView [ModelSQL ModelView]
  "Hello Summary"
  [--name-- "hello.summary_view"
   title (.Many2One fields "hello.title" "Title")
   num (.Integer fields "Count")]

  (with-decorator classmethod
    (defn table_query [cls]
      (setv Hello (.get (Pool) "hello")
            table-hello (.__table__ Hello)
            query (.select table-hello
                           (.as_ (Max table-hello.id) "id")
                           (.as_ table-hello.title "title")
                           (.as_ (Count table-hello.title) "num")
                           (.as_ (Literal 0) "create_uid")
                           (.as_ (CurrentTimestamp) "create_date")
                           (.as_ (Literal None) "write_uid")
                           (.as_ (Literal None) "write_date"))
            query.group-by table-hello.title)
      query
      ;;(.table_query (super Hello cls))
      )))
