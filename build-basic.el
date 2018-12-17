;; -*- coding: utf-8 -*-
(require 'cl)
(defconst *split-dot* (if (eq system-type 'gnu/linux) ":" ";" ))
(defconst *java-home-bin* "/opt/java/jdk1.6.0_45/bin/")
;;指定lib仓库，可以指定多个lib路径
(defconst *lib-repository-path* '("../../workspace/repository/lib"))

(defun directory-dirs (dir)
  "Find all directories in DIR."
  (unless (file-directory-p dir)
    (error "Not a directory `%s'" dir))
  (let ((dir (directory-file-name dir))
        (dirs '())
        (files (directory-files dir nil nil t)))
    (dolist (file files)
      (unless (member file '("." ".."))
        (let ((file (concat dir "/" file)))
          (when (file-directory-p file)
            (setq dirs (append (cons file
                                     (directory-dirs file))
                               dirs))))))
    dirs))

(defun get-javasrc-files (fext)
(setq javafiles '())
(dolist (file (directory-dirs "src"))
;; (message "%s" file)
;(if (> (length (directory-files (concat file ".") nil ".java$" 'nosort)) 0) (message "%s" file) ())
(if (> (length (directory-files file nil (format ".%s$" fext) 'nosort)) 0) (setq javafiles (append (list (format "%s/*.%s" file fext)) javafiles) ) ())
        )
javafiles
  )


(defun get-jar-files(jarlist)
(setq jarpath *lib-repository-path*)
(setq jarfiles '())
(dolist (path jarpath)
  (setq path (expand-file-name path))
  (dolist (file jarlist)

(progn

                                       (setq jarfile (format "%s/%s.jar" path (symbol-name file)))

                                       (if (file-exists-p jarfile)
                                           (setq jarfiles (append jarfiles (list (format "%s/%s.jar" path (symbol-name file)))))
                                         ()
                                         )

                                       )
    )
;; (dolist (file (directory-files (concat path ".") nil ".jar$" 'nosort)) (setq jarfiles (append jarfiles (list (format "%s/%s" path file)))))
  )
jarfiles
  )


(defun chk-jar-files(jarlist)
(setq jarpath *lib-repository-path*)
(dolist (path jarpath)

(dolist (file jarlist) (progn

                                       (setq jarfile (format "%s/%s.jar" path (symbol-name file)))

                                       (if (file-exists-p jarfile)
                                           ()
                                         (message "找不到文件==>%s" jarfile)
                                         )

                                       ) )
;; (dolist (file (directory-files (concat path ".") nil ".jar$" 'nosort)) (setq jarfiles (append jarfiles (list (format "%s/%s" path file)))))
  )
)

(defun get-jar-files-list()
  '(
;;由调用程序覆写
    )
  )

(defun get-umljar-files-list()
  '(
    plantuml
    jlatexmath-1.0.4
    )
  )


;;强制编译所有类文件
(defun get-build-cmd ()
  ;; (list (format "/opt/java/aspectj1.6/bin/ajc -1.6 -encoding utf-8 -nowarn -classpath \"/opt/java/aspectj1.6/lib/aspectjrt.jar:%s\" -d %s %s" (mapconcat 'identity (get-jar-files (get-jar-files-list)) *split-dot*) "WebRoot/WEB-INF/classes" (mapconcat 'identity (get-javasrc-files "java") " ")))
  (list (format "%sjavac -Xlint:unchecked -encoding utf-8 -nowarn -source 1.6 -target 1.6 -sourcepath . -classpath \"%s\" -d %s %s" *java-home-bin* (mapconcat 'identity (get-jar-files (get-jar-files-list)) *split-dot*) "WebRoot/WEB-INF/classes" (mapconcat 'identity (get-javasrc-files "java") " ")))
  )


;;仅在源文件修改后编译
(defun get-build-cmd-src ()
  (list (format "javac -encoding utf-8 -nowarn -classpath \"%s%s%s\" -d %s %s" "WebRoot/WEB-INF/classes" *split-dot*  (mapconcat 'identity (get-jar-files (get-jar-files-list)) *split-dot*) "WebRoot/WEB-INF/classes" (mapconcat 'identity (get-javasrc-files "java") " ")))
  )

(defun get-test-cmd (mainclass)
  (if (eq nil mainclass) (setq mainclass ""))
  (list (format "java -classpath \"%s%sWebRoot/WEB-INF/classes\" %s" (mapconcat 'identity (get-jar-files (get-jar-files-list)) *split-dot*) *split-dot* mainclass))
  )

(defun get-uml-cmd (mainclass)
  (if (eq nil mainclass) (setq mainclass ""))
  (list (format "java -classpath \"%s\" %s" (mapconcat 'identity (get-jar-files (get-umljar-files-list)) *split-dot*) mainclass))
  )



(defun get-clear-cmd ()
  (list "rm -f -r WebRoot/WEB-INF/classes/cn/tianya" )
  )


(defun run-common-cmd (cmdlist)
(dolist (ppp cmdlist)
  (message "%s" ppp);;测试用
                                        ;(shell-command ppp)

;;(message "cd %s" default-directory)
(message "%s" (shell-command-to-string ppp) )
;; (message "%s" (encode-coding-string (shell-command-to-string ppp) 'utf-8) )
  )
)


;; (message "%s" (shell-command-to-string ppp) )
;; (format "java -classpath \"%s%sWebRoot/WEB-INF/classes\" %s" (mapconcat 'identity (get-jar-files (get-jar-files-list)) *split-dot*) *split-dot* mainclass)


(defun run-output-cmd (cmdlist)
(dolist (ppp cmdlist)
  (message "%s" ppp);;测试用
                                        ;(shell-command ppp)

;;(message "cd %s" default-directory)
;; (message "%s" (shell-command-to-string ppp) )
;; (message "%s" (encode-coding-string (shell-command-to-string ppp) 'utf-8) )
  )
)



(defun run-common2-cmd (cmdlist)
(dolist (ppp cmdlist)
  (message "%s" ppp);;测试用
;(shell-command ppp)

  (eshell "new")
  (insert ppp)
  (eshell-send-input)

;; (start-process-shell-command "only-cmd" buf  ppp )
;; (if (eq nil buf) () (switch-to-buffer buf))
  ;; (async-shell-command
  ;;      ppp "*mplayer*" )
  ;; (start-process-shell-command "only-cmd" nil ppp)
;; (message "%s" (shell-command-to-string ppp) )
;; (message "%s" (encode-coding-string (shell-command-to-string ppp) 'utf-8) )
  )
  )


(defun run-build-cmd ()
(run-common-cmd (get-build-cmd))
)



(defun run-test-cmd (&rest cmdlist)
  (setq ttt "")
  (dolist (ppp cmdlist)

    (setq ttt (format "%s %s" ttt ppp))
  )
  (run-common-cmd (get-test-cmd ttt))
  )

(defun run-uml-cmd (&rest cmdlist)
  (setq ttt "")
  (dolist (ppp cmdlist)

    (setq ttt (format "%s %s" ttt ppp))
  )
  (run-common-cmd (get-uml-cmd ttt))
  )


(defun run-test2-cmd (mainclass)
(run-common2-cmd (get-test-cmd mainclass))
  )

(defun run-clear-cmd ()
(run-common-cmd (get-clear-cmd))
  )

(defun do-test-func (var1 var2 &optional opt1 opt2 &rest rest)
(list var1 var2 opt1 opt2 rest))


;;是否有命令行
(defun do-main(args)
  ;; (message "ttt=>%s,%s" (length args) args)
(if (eq nil (elt args 0)) () (apply (read (elt args 0)) (cdr args) ))
  )

(provide 'build-basic)
