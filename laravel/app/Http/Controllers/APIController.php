<?php

namespace App\Http\Controllers;
use App\Models\User;
use App\Models\Product;
use App\Models\Todo;
use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
class APIController extends Controller
{
    public function index()
    {
        $products = Product::paginate(10); // دریافت محصولات با صفحه‌بندی ۱۰ تایی

        return view('admin.products.index', compact('products'));
    }
    public function search(Request $request)
    {
        $query = $request->input('q');
        $products = Product::where('name', 'like', '%' . $query . '%')->get();
         return response()->json($products);
        // return $products;
    }
    public function register (Request $request) {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6',
        ]);
        if ($validator->fails())
        {
            return response(['errors'=>$validator->errors()->all()], 422);
        }
        $request['password']=Hash::make($request['password']);
        $request['remember_token'] = Str::random(10);
        $user = User::create($request->toArray());
        // $token = $user->createToken('Laravel Password Grant Client')->accessToken;
        $token = $user->createToken('auth_token');

        $response = ['token' => $token->plainTextToken];
        return response($response, 200);
    }
    public function login (Request $request) 
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|string|email|max:255',
            'password' => 'required|string|min:6',
        ]);
        if ($validator->fails())
        {
            return response(['errors'=>$validator->errors()->all()], 422);
        }
        $user = User::where('email', $request->email)->first();
        if ($user) {
            if (Hash::check($request->password, $user->password)) {
                $token = $user->createToken('auth_token');
                // $token = $user->createToken('Laravel Password Grant Client')->accessToken;
                $response = ['token' => $token->plainTextToken];
                return response($response, 200);
            } else {
                $response = ["message" => "Password mismatch"];
                return response($response, 422);
            }
        } else {
            $response = ["message" =>'User does not exist'];
            return response($response, 422);
        }
    }
    public function store(Request $request)
    {
        // اعتبار سنجی درخواست
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'required|string',
            'price' => 'required|numeric|min:0',
            'category_id' => 'required|exists:categories,id',
            'image' => 'nullable|image|max:2048',
        ]);

        // ایجاد شیء محصول و ذخیره در دیتابیس
        $product = new Product();
        $product->name = $validated['name'];
        $product->description = $validated['description'];
        $product->price = $validated['price'];
        $product->category_id = $validated['category_id'];

        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('images');
            $product->image = $imagePath;
        }

        $product->save();

        // بازگشت به لیست محصولات
        return redirect()->route('admin.products.index')
                        ->with('success', 'محصول با موفقیت ایجاد شد.');
    }
    //درخواست از طریق API
    public function storeAPI(Request $request)
    {
        // اعتبار سنجی درخواست
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'user_id' => 'required|string',
        ]);

        // ایجاد شیء محصول و ذخیره در دیتابیس
        $Category = new Category();
        $Category->name = $validated['name'];
        $Category->user_id = $validated['user_id'];
        $Category->save();

        // بازگشت به لیست محصولات
        return response()->json($Category);

    }
     public function CreateTodo(Request $request)
    {
        // اعتبار سنجی درخواست
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'required|string|max:255',
            'category_id' => 'required|string',
        ]);

        // ایجاد شیء محصول و ذخیره در دیتابیس
        $Todo = new Todo();
        $Todo->title = $validated['title'];
        $Todo->description = $validated['description'];
        $Todo->category_id = $validated['category_id'];
        $Todo->save();

        // بازگشت به لیست محصولات
        return response()->json($Todo);

    }
    
    public function create()
    {
        $categories = Category::all();
        return view('admin.products.create', compact('categories'));
    }
    public function edit($id)
    {
        $product = Product::findOrFail($id);
        $categories = Category::all();
        return view('admin.products.edit', compact('product', 'categories'));
    }
    public function getUsers()
    {
        $users = User::all();
        return response()->json($users);
    }
    public function todo($id)
    {
        $todo = Todo::where('category_id',$id)->get();
        return response()->json($todo);
    }
    public function categories($id)
    {
        $categories = Category::where('user_id',$id)->get();
        // $categories = Category::all();
        return response()->json($categories);
    }
    public function product($id)
    {
        $product = Product::find($id);

        if (!$product) {
            return response()->json([
                'success' => false,
                'message' => 'Product not found'
            ]);
        }
        return response()->json($product);
    }
    
    public function update(Request $request, $id)
    {
       $validated = $request->validate([
            'name' => 'required|string|max:255',
        ]);
        $Category = Category::find($id);

        if (!$Category) {
            return response()->json([
                'success' => false,
                'message' => 'Product not found'
            ]);
        }
        $Category->name = $validated['name'];
        $Category->save();

	 return response()->json('success');

    }
     public function TodoUpdate(Request $request, $id)
    {
       $validated = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'required|string|max:255',
        ]);
        $Todo = Todo::find($id);

        if (!$Todo) {
            return response()->json([
                'success' => false,
                'message' => 'Product not found'
            ]);
        }
        $Todo->title = $validated['title'];
        $Todo->description = $validated['description'];
        $Todo->save();

	 return response()->json('success');

    }
      public function todoStatus(Request $request, $id)
    {
       $validated = $request->validate([
            'status' => 'required|string|max:255',
        ]);
        $Todo= Todo::find($id);

        if (!$Todo) {
            return response()->json([
                'success' => false,
                'message' => 'Todo not found'
            ]);
        }
        $Todo->status= $validated['status'];
        $Todo->save();

	 return response()->json('success');

    }
    public function destroy($id)
    {
        $Category = Category::find($id);

        if (!$Category) {
            return response()->json([
                'success' => false,
                'message' => 'Product not found'
            ]);
        }

        $Category->delete();

        return response()->json([
            'success' => true,
            'message' => 'Category deleted successfully'
        ]);
    }
     public function destroyTodo($id)
    {
        $Todo = Todo::find($id);

        if (!$Todo) {
            return response()->json([
                'success' => false,
                'message' => 'Product not found'
            ]);
        }

        $Todo->delete();

        return response()->json([
            'success' => true,
            'message' => 'Todo deleted successfully'
        ]);
    }
    public function delete($id)
    {
        $product = Product::find($id);

        if (!$product) {
            return response()->json([
                'success' => false,
                'message' => 'Product not found'
            ]);
        }

        $product->delete();
        return redirect()->route('admin.products.index')
        ->with('success', 'محصول با موفقیت حذف شد.');
    }
}
