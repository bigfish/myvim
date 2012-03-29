#!/usr/bin/env node
/*jslint node:true*/
var fs = require('fs'),
    exec = require('child_process').exec,
    repos = {
        'git-vim': 'https://github.com/motemen/git-vim.git',
        'nerdtree': 'https://github.com/scrooloose/nerdtree.git',
        'snipmate.vim': 'https://github.com/msanders/snipmate.vim.git',
        'The-NERD-Commenter': 'https://github.com/vim-scripts/The-NERD-Commenter.git',
        'vim4js': 'git@github.com:bigfish/vim4js.git',
        'vim-js-beautify': 'git@github.com:bigfish/vim-js-beautify.git'
    },
    repo;

function get_repo (dir) { 
    var url = repos[dir],
        path = 'bundle/' + dir;

    fs.readdir(path, function(err, files) {
        if (err) {
            console.log(err);
            //dir does not exist -- clone dir
            console.log("cloning " + dir + " repo into ");
            exec('git clone ' + url + ' bundle/' + dir, function (err, stdout, stderr) {
                if (err) {
                    throw err;
                } else {
                    console.log("added '"+dir+"' repo.");
                }
            });
        } else {
            console.log("found dir: " + dir);
        }
    });
}

for (repo in repos) {
    get_repo(repo);
}


