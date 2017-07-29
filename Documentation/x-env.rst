x-env
#####

Access X11 from outside shell
-----------------------------

:Manual section: 1
:Date: 2017-07-29
:Author: Jan Matějka yac@blesmrt.net
:Manual group: x-env manual

DESCRIPTION
===========

Suppose you have a box running X11 you want to ssh into quite often. Like
an HTPC. And suppose you want to run X apps from the ssh session.

Usually you would need to only export the correct ``DISPLAY`` and you are
set. But the value you need may differ between different operating systems
or environments.

``x-env`` will read the ``DISPLAY`` (and all the other environment
variables for good measure) from an existing process running within the
X11, which we will call anchor. The anchor is a string pattern for
``man 1 pgrep`` to uniquely identify the process you want to import
environment from. The anchor is read from
``$XDG_CONFIG_HOME/x-env/anchor`` file.

Then you can view the would-be exported variables by running::

  x-env exports

Import them into your shell::

  eval $(x-env exports)

Or if you want to do that automatically when you ssh in, just drop::

  . x-env-auto-ssh

In the the config file of your shell which will export the variables of
anchor iff the shell is started from ssh.

INSTALLATION
============

make install

DEPENDENCIES
============

Build:

* python-docutils

* GNU make

Runtime:

* sh

* `xdgenv <https://github.com/yaccz/xdgenv>`_

.. include:: common-foot.rst
