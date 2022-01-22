const express = require('express')
const { render } = require('express/lib/response')
const multer = require('multer')
const router = express.Router()
const path = require('path')
const author = require('../models/author')
const Book = require('../models/book')
const uploadPath = path.join('public', Book.coverImageBasePath)
const imageMimeTypes = ['image/jpeg', 'image/png', 'image/gif']
const upload = multer({
    dest: uploadPath,
    fileFilter: (req, file, callback) => {
        callback(null, imageMimeTypes.includes(file.mimetype))
    }
})

// All Bookss Route
router.get('/', async (req, res) => {
    res.send('All Books')
})

// New Book Route
router.get('/new', async (req, res) => {
    renderNewPage(res, new Book())
})

// Create Book Route
router.post('/', upload.single('cover'), async (req, res) => {
    const fileNAme = req.file != null ? req.file.filename : null
    const book = new Book({
        title: req.body.title,
        author: req.body.author,
        publishDate: new Date(req.body.publishDate),
        pageCount: req.body.pageCount,
        coverImageName: fileName,
        description: req.body.description
    })
    
    try {
        const newBook = await book.save()
        // res.redirect('books/${newBook.id}')
        res.redirect('books')
    } catch {
        renderNewPage(res, book, true)
    }

})

async function renderNewPage(res, book, hasError = false) {
    try {
        const authors = await author.find({})
        const params = {
            authors: authors,
            book: book
        }
        if (hasError) params.errorMessage = 'Error Creating Book'
        res.render('books/new', params)
    } catch {
        res.redirect('/books')
    }
}

module.exports = router