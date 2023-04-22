<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Todo extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'description',
        'status',
        'category_id'
    ];
    public function categories()
    {
        return $this->belongsToMany(Category::class);
    }
    public function category()
    {
        return $this->belongsTo(Category::class);
    }
}